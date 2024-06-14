<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $title = fake()->unique()->name();
        $slug = Str::slug($title);

        $subcategories = [4,5];
        $subcatRandKey = array_rand($subcategories);
        $subCategoryId = $subcategories[$subcatRandKey];  // Get the value, not the key
        
        $brands = [1, 2, 3, 4];
        $brandRandKey = array_rand($brands);
        $brandId = $brands[$brandRandKey];  // Get the value, not the key

        return [
            'title' => $title,
            'slug' => $slug,
            'category_id' => 1,
            'sub_category_id' => $subCategoryId,
            'brand_id' => $brandId,
            'price' => rand(10, 1000),
            'sku' => rand(1000, 10000),
            'track_qty' => 'Yes',
            'qty' => 10,
            'is_featured' => "Yes",
            'status' => 1,
        ];
    }
}
