/**
 * @author sourabhRai
 * use these directive as generic directive. Include this js in your jsp and just call them
 */


publicModule.directive('validateFields', function() {
	return {
		restrict: 'A',
		require: 'ngModel',
		link: function(scope, element, attr, ctrl) {
			ctrl.$parsers.unshift(function(viewValue) {
				var options = scope.$eval(attr.validateFields);
				
				if(viewValue == ""){
					toastr.error(options.name  + " is required");
					element[0].setAttribute("style", "border: 2px solid red;");
				}else{
					element[0].setAttribute("style", "");
				}
				return viewValue;
			});
		}
	};
})

publicModule.directive('restrictInput', function() {
	return {
		restrict: 'A',
		require: 'ngModel',
		link: function(scope, element, attr, ctrl) {
			ctrl.$parsers.unshift(function(viewValue) {
			var options = scope.$eval(attr.restrictInput);
					if (!options.regex && options.type) {
					switch (options.type) {
						case 'digitsOnly': options.regex = '^[0-9]*$'; break;
						case 'monthOnly': options.regex = '^(0?[1-9]|1[012])$'; break;
						case 'lettersOnly': options.regex = '^[a-zA-Z]*$'; break;
						case 'lowercaseLettersOnly': options.regex = '^[a-z]*$'; break;
						case 'uppercaseLettersOnly': options.regex = '^[A-Z]*$'; break;
						case 'lettersAndDigitsOnly': options.regex = '^[a-zA-Z0-9]*$'; break;
						case 'validPhoneCharsOnly': options.regex = '^[0-9 ()/-]*$'; break;
						case 'numberGreaterThanZero' : options.regex = '^[1-9][0-9]*$'; break;
						default: options.regex = '';
					}
				}
			var reg = new RegExp(options.regex);
			
			if (reg.test(viewValue)) { //if valid view value, return it
//				scope.pesaPlan.pesaPlanDetails[options.index].funds = (scope.pesaPlan.pesaPlanDetails[options.index].noOfUnits * scope.pesaPlan.pesaPlanDetails[options.index].unitCostPerMonth * scope.pesaPlan.pesaPlanDetails[options.index].noOfMonths);
				return viewValue;
			} else { //if not valid view value, use the model value (or empty string if that's also invalid)
			
			var overrideValue = (reg.test(ctrl.$modelValue) ? '' : '');
			element.val(overrideValue);
			return overrideValue;
			}
			});
		}
	};
})

publicModule.directive('convertToNumber', function() {
	return {
		require: 'ngModel',
		link: function (scope, element, attrs, ngModel) {
				ngModel.$parsers.push(function(val) {
				return parseInt(val, 10);
			});
				ngModel.$formatters.push(function (val) {
				return '' + val;
		});
		}
	};
});