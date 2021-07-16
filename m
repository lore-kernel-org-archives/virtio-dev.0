Return-Path: <viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 0/2] virtio: Add specification for virtio-gpio
Date: Fri, 16 Jul 2021 13:09:17 +0530
Message-Id: <cover.1626418779.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

This patchset adds virtio specification for GPIO devices. It supports basic GPIO
line operations, along with optional interrupts on them (in a separate patch).

This is an *alternative implementation* of the virtio-gpio specification,
another version of it was earlier posted by Enrico [1].

I took back V4 of the specification I posted earlier (on June 17th), to allow
Enrico to come up with something that is robust and works for everyone (as he
started this thing last year), but it didn't go as expected. I couldn't
see any of my review comments being incorporated (or any intentions of them
getting in ever) in the two versions Enrico posted and a month passed since
then.

And so I am trying to present an alternative approach here to solve the problem,
which I believe is more clear and robust. I am open to suggestions to improve it
further.

I will let the virtio/gpio maintainers decide on its fate.

Key differences from Enrico's approach [1]:

- config structure is rearranged to remove unnecessary fields/padding, and place
  gpio_names block in such a way that we can expand the structure easily going
  forward, if required.

- Supports freeing of a GPIO line after use.

- Interrupt implementation handled with feature bit 0. Either the interrupts are
  fully supported or not at all.

- Doesn't add any ordering restrictions on the device, it can respond earlier to
  the second request, while still processing the first one.

- Clearly state that two requests can't be initiated for the same line by device
  or driver.


Version history of the specification I sent:

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

 conformance.tex |  26 ++-
 content.tex     |   3 +-
 virtio-gpio.tex | 464 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 488 insertions(+), 5 deletions(-)
 create mode 100644 virtio-gpio.tex

-- 
2.31.1.272.g89b43f80a514

