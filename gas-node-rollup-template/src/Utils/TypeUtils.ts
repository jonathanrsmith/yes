

/* Collection of type checking utilities. */
/** Checks if this is a *pure* object, it is not a function, array, or other object derived typed. */
export function isObject_(arg) {
  return arg != null && Object.prototype.toString.call(arg) === '[object Object]';
}
// eslint-disable-next-line @typescript-eslint/no-unsafe-function-type
export function isFunction_(arg): arg is Function {
  return arg != null && Object.prototype.toString.call(arg) === '[object Function]';
}
export function isPromise_(arg): arg is Promise<unknown> {
  return arg != null && Object.prototype.toString.call(arg) === '[object Promise]';
}
export function isString_(arg): arg is string {
  return arg != null && Object.prototype.toString.call(arg) === '[object String]';
}
export function isNumber_(arg): arg is number {
  return arg != null && Object.prototype.toString.call(arg) === '[object Number]';
}
export function isBool_(arg): arg is boolean {
  return arg != null && Object.prototype.toString.call(arg) === '[object Boolean]';
}
export function isDate_(arg): arg is Date {
  return arg != null && Object.prototype.toString.call(arg) === '[object Date]';
}
export function isArray_(arg): arg is unknown[] {
  return arg != null && Array.isArray(arg);
}
export function isError_(arg): arg is Error {
  return arg != null && Object.prototype.toString.call(arg) === '[object Error]';
}
/**
 * Checks if value is or can be converted to a Date and that the Date is valid (non-NaN).
 * @param {string|number|Date|null} date
 */
export function isValidDate_(date: string | number | Date | null) {
  if (date === null) {
    return false;
  }

  if (isString_(date) || isNumber_(date)) {
    date = new Date(date);
  }

  return isDate_(date) && !isNaN(date.getTime());
}
export function isValidNumber_(arg: string | number | null): boolean {
  if (arg == null) {
    return false;
  }

  if (isString_(arg)) {
    arg = toFloat_(arg);
  }

  return !isNaN(arg) && isFinite(arg);
}
/**
 * Checks if value is a string, and that string is a valid date.
 * @param str
 */
export function isStringDate_(str): str is string {
  return isString_(str) && isValidDate_(str);
}


/* Collection of type conversion utilities. */
/**
 * Converts string to integer. If NaN, returns 0.
 */
export function toInt_(arg: string, defaultVal: number = 0) {
  const number = parseInt(arg, 10);
  return Number.isNaN(number) ? defaultVal : number;
}
/**
 * Converts string to float. If NaN, returns 0.
 */
export function toFloat_(arg: string, defaultVal: number = 0) {
  const number = parseFloat(arg);
  return Number.isNaN(number) ? defaultVal : number;
}
// NOTE: this isn't trying to coerce a string into a boolean, rather it's checking if the value is the literal toString() result, IE if you'd written a boolean to localStorage.
//       If necessary for a more general boolean conversion, create a boolLike method instead.
/**
 * Converts string to bool if "true" or "false". If it is not a valid result, returns false.
 */
export function toBool_(arg: string, defaultVal: boolean = false) {
  arg = arg?.toLocaleLowerCase();

  // We don't simply use `return arg === 'true'` because a non-value should be an invalid bool.
  if (arg === 'true') {
    return true;
  }
  if (arg === 'false') {
    return false;
  }

  return defaultVal;
}
/**
 * Ensures that the value passed will be a Date object if it can become one, or otherwise null.
 */
export function toDate_(date: string | number | Date | null): Date | null {
  if (isString_(date) || isNumber_(date)) {
    date = new Date(date);
  }

  return date;
}

/** Maps an array to an object because I hate using `arr.reduce(...)` to handle this. */
export function toObjectFromArray_<T>(arr: Array<T>, keyFunc: (item: T) => string | number): Record<string | number, T> {
  const result: Record<string | number, T> = {};

  for (let i = 0; i < arr.length; i++) {
    const item = arr[i];
    const key = keyFunc(item);
    result[key] = item;
  }

  return result;
}
