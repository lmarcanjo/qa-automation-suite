import { test, expect } from '@playwright/test';

test.describe('Sauce Demo - E2E ⚔️', () => {

  test.beforeEach(async ({ page }) => {
    await page.goto('https://www.saucedemo.com/');
  });

  // 1. Bloco de Login
  const loginScenarios = [
    { user: 'invalid_user', pass: 'secret_sauce', err: 'Username and password do not match' },
    { user: '', pass: 'secret_sauce', err: 'Username is required' },
    { user: 'standard_user', pass: '', err: 'Password is required' },
    { user: 'locked_out_user', pass: 'secret_sauce', err: 'Epic sadface: Sorry, this user has been locked out' }
  ];

  for (const c of loginScenarios) {
    test(`Login Negativo: ${c.user || 'Vazio'} - ${c.pass || 'Vazio'}`, async ({ page }) => {
      if (c.user) await page.fill('[data-test="username"]', c.user);
      if (c.pass) await page.fill('[data-test="password"]', c.pass);
      await page.click('[data-test="login-button"]');
      await expect(page.locator('[data-test="error"]')).toContainText(c.err);
    });
  }

  // 2. Bloco de Ordenação (Filtros)
  const sortScenarios = [
    { sort: 'az', expected: 'Sauce Labs Backpack' },
    { sort: 'za', expected: 'Test.allTheThings() T-Shirt (Red)' },
    { sort: 'lohi', expected: 'Sauce Labs Onesie' },
    { sort: 'hilo', expected: 'Sauce Labs Fleece Jacket' }
  ];

  for (const s of sortScenarios) {
    test(`Filtro de Produtos: ${s.sort}`, async ({ page }) => {
      await page.fill('[data-test="username"]', 'standard_user');
      await page.fill('[data-test="password"]', 'secret_sauce');
      await page.click('[data-test="login-button"]');
      await page.locator('[data-test="product-sort-container"]').selectOption(s.sort);
      const firstItemTitle = await page.locator('.inventory_item_name').first().innerText();
      expect(firstItemTitle).toContain(s.expected);
    });
  }

  // 3. Adicionar pelo Detalhe e Voltar (Continue Shopping)
  test('Carrinho via Detalhes e Continue Shopping', async ({ page }) => {
    await page.fill('[data-test="username"]', 'standard_user');
    await page.fill('[data-test="password"]', 'secret_sauce');
    await page.click('[data-test="login-button"]');
    await page.locator('[data-test="item-4-title-link"]').click();
    await page.locator('[data-test="add-to-cart"]').click();
    await expect(page.locator('[data-test="shopping-cart-link"]')).toBeVisible();
    await expect(page.locator('[data-test="shopping-cart-link"]')).toHaveText('1');
    await page.click('[data-test="back-to-products"]');
    await expect(page).toHaveURL(/.*inventory.html/);
  });

  // 4. Testes de Checkout Vazios
  test('Checkout Cancelado e Validações de Erro', async ({ page }) => {
    await page.fill('[data-test="username"]', 'standard_user');
    await page.fill('[data-test="password"]', 'secret_sauce');
    await page.click('[data-test="login-button"]');
    
    await page.click('[data-test="add-to-cart-sauce-labs-onesie"]');
    await page.click('.shopping_cart_link');
    await page.click('[data-test="checkout"]');

    // Erros
    await page.click('[data-test="continue"]');
    await expect(page.locator('[data-test="error"]')).toHaveText('Error: First Name is required');
    await page.fill('[data-test="firstName"]', 'Asta');
    await page.click('[data-test="continue"]');
    await expect(page.locator('[data-test="error"]')).toHaveText('Error: Last Name is required');
    await page.fill('[data-test="lastName"]', 'Blackbull');
    await page.click('[data-test="continue"]');
    await expect(page.locator('[data-test="error"]')).toHaveText('Error: Postal Code is required');

    // Botão Cancelar
    await page.click('[data-test="cancel"]');
    await expect(page).toHaveURL(/.*cart.html/);
  });

  // 5. Teste do Bug do Problem User
  test('Mapeando Bug de Imagem do problem_user', async ({ page }) => {
    await page.fill('[data-test="username"]', 'problem_user');
    await page.fill('[data-test="password"]', 'secret_sauce');
    await page.click('[data-test="login-button"]');
    
    // Todas as imagens do problem user estão quebradas (apontam para uma imagem de cachorro ou dão 404)
    const firstImgSrc = await page.locator('.inventory_item_img img').first().getAttribute('src');
    expect(firstImgSrc).toContain('sl-404');
  });

  // 6. Teste de Footer
  test('Footer Links Externos', async ({ page }) => {
    await page.fill('[data-test="username"]', 'standard_user');
    await page.fill('[data-test="password"]', 'secret_sauce');
    await page.click('[data-test="login-button"]');
    
    await expect(page.locator('a[href="https://twitter.com/saucelabs"]')).toBeVisible();
    await expect(page.locator('a[href="https://www.facebook.com/saucelabs"]')).toBeVisible();
    await expect(page.locator('a[href="https://www.linkedin.com/company/sauce-labs/"]')).toBeVisible();
  });
});