#include <stdio.h>
#include "unity.h"


extern "C" {
#include "Mockmy_component_dependency.h"
#include "my_component.h"
}

void test_my_component()
{
  func_dependency_Expect();
  TEST_ASSERT_EQUAL(1, func());
}

int main(int argc, char **argv)
{
  UNITY_BEGIN();
  RUN_TEST(test_my_component);
  int failures = UNITY_END();
  return failures;
}
