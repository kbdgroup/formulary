-- update dpd.active_ingredient.ingredient and dpd.active_ingredient.strength
UPDATE dpd.active_ingredient tgt
SET
    ingredient =
    CASE WHEN ccdd_ingredient IS NOT NULL
    THEN ccdd_ingredient ELSE tgt.ingredient END,
    strength =
    CASE WHEN ccdd_strength IS NOT NULL
    THEN ccdd_strength ELSE tgt.strength END
FROM dpd.active_ingredient_src src
WHERE (
        src.ccdd_ingredient IS NOT NULL OR
        src.ccdd_strength IS NOT NULL
      ) AND
      tgt.drug_code = src.drug_code AND
      tgt.active_ingredient_code = src.active_ingredient_code AND
      tgt.ingredient = src.ingredient AND
      tgt.strength = src.strength;

-- update dpd.route.route_of_administration
UPDATE dpd.route tgt
SET route_of_administration = ccdd_route_of_administration
FROM dpd.route_src src
WHERE src.ccdd_route_of_administration IS NOT NULL AND
      tgt.drug_code = src.drug_code AND
      tgt.route_of_administration = src.route_of_administration;

-- update dpd.pharmaceutical_form.pharmaceutical_form
UPDATE dpd.pharmaceutical_form tgt
SET pharmaceutical_form = ccdd_pharmaceutical_form
FROM dpd.pharmaceutical_form_src src
WHERE src.ccdd_pharmaceutical_form IS NOT NULL AND
      tgt.pharm_form_code = src.pharm_form_code AND
      tgt.drug_code = src.drug_code;
