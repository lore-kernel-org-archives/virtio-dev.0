Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 0/2] virtio: Add specification for virtio-gpio
Date: Fri, 30 Jul 2021 12:15:01 +0530
Message-Id: <cover.1627627021.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

This patchset adds virtio specification for GPIO devices. It supports basic GPIO
line operations, along with optional interrupts on them (in a separate patch).

This is an *alternative implementation* of the virtio-gpio specification, a
different version of it was earlier posted by Enrico [1].

I took back V4 of the specification I posted earlier (on June 17th), to allow
Enrico to come up with something that is robust and works for everyone (as he
started this thing last year), but it didn't go as expected. I couldn't
see any of my review comments being incorporated (or any intentions of them
getting in ever) in the three versions Enrico posted until now.

This patchset is already reviewed by Linus (GPIO Maintainer) and Arnd.

Key differences from Enrico's approach [1]:

- config structure is rearranged to remove everything apart from number of gpios
  and size of the gpio_names_field.

- Request/free is merged with set-direction itself.

- Interrupt implementation handled with feature bit 0. Either the interrupts are
  fully supported or not at all.

- All non-interrupt traffic happens on a single virtqueue, requestq. Interrupt
  traffic goes over eventq.

- Doesn't add any ordering restrictions on the device for different GPIO lines,
  it can respond earlier to the second request, while still processing the first
  one.



Version history of the my changes:

V7 -> V8:
- Use fixed-length struct virtio_gpio_response for all requests and define a
  separate structure for get-names.
- Explicitly write the expected values of direction in the get/set-direction
  tables.
- Better/detailed interrupt handling information, based on fast-eoi mechanism
  now, where the driver notifies the device only once after the interrupt is
  handled.
- Added reviewed-by tags collected so far.

V6 -> V7:
- Drop Activate/Deactivate requests and merge them with set-direction one.
- Dropped separate calls to set direction to input or output (with a value),
  with a single call to set-direction (input, output, or none). Note that the
  driver needs to call set-value before calling set-direction-out now.
- Allow multiple messages for a GPIO line to be sent together, they must be
  processed in order though.
- The gpio-line names aren't required to be set for all the lines now, it is
  optional and can be present only for a subset of lines. Provided example as
  well.
- Merge irq-set/mask/unmask to a single set-irq-type message.
- We have only 6 message types now instead of 11 in v6.
- Mentioned about non-atomic nature of the these messages in commit log for
  patch 1/2.
- Improved spec content overall.

V5 -> V6:
- All non-interrupt traffic happens on a single virtqueue, requestq. Interrupt
  traffic goes over eventq now.
- Many fields dropped from the config structure.
- Separate message type to get gpio-names, added more description about how the
  names should be.
- Much clearer message flows, both non-irq messages and irq-messages.
- Parallelism supported for all type of messages, for different GPIO pins.
- All references to POSIX errors dropped, just reply pass or fail.
- request/free renamed to activate/deactivate, as that's what we will end up
  doing there, activate or deactivate a GPIO line.
- General purpose IO as I/O or Input/Output instead.
- Hopefully I didn't miss any review comments.

V4 -> V5:
- Split into two patches, irq stuff in patch 2.
- Use separate virtqueue for sending data from device/driver.
- Allow parallel processing of requests for different GPIOs, only one request at
  a time for the same GPIO line.
- Same goes for interrupt side, only one interrupt request per GPIO line.
- Improved formatting in general.
- Add new sections explaining message flow sequence.

V3 -> V4:
- The GPIO line names must be unique within a device.
- The gpio_names[0] field is dropped and gpio_names_offset field is
  added in place of the 2 bytes of padding.
- New interrupts must not be initiated by the device, without a response
  for the previous one.

V2 -> V3:
- Unused char in name string should be marked 0 now.
- s/host/device/ and s/guest/driver/
- Added a new feature for IRQ mode, VIRTIO_GPIO_F_IRQ.
- A new feature should be added for Version information if required
  later on.

V1 -> V2:
- gpio_names_size is 32 bit.
- gpio field is 16 bit.
- padding added 16 bit.
- Added packed attribute to few structures
- Add the missing 'type' field to the request
- Dropped to _nodata request/responses to simplify a bit, updated
  related text.

--
Viresh

[1] https://lists.oasis-open.org/archives/virtio-dev/202106/msg00030.html

Viresh Kumar (2):
  virtio-gpio: Add the device specification
  virtio-gpio: Add support for interrupts

 conformance.tex |  30 ++-
 content.tex     |   1 +
 virtio-gpio.tex | 578 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 605 insertions(+), 4 deletions(-)
 create mode 100644 virtio-gpio.tex

-- 
2.31.1.272.g89b43f80a514

