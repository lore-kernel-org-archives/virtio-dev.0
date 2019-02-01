Return-Path: virtio-dev-return-5364-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 14051985FFC
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Feb 2019 20:34:21 +0000 (UTC)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Fri, 1 Feb 2019 12:34:07 -0800
Message-ID: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Memory sharing device
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

for our purposes we need to access host's memory (e.g. Vulkan buffers,
but we also considering other things, like running all drivers in
userspace) directly from a linux guest (Android). I implemented a
device in QEMU and a linux driver for it:

https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/misc/goldfish_address_space.c

https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c

during upstreaming the driver it was suggested that developing a
virtio spec could be a better approach than inventing our specific
driver and device.

Could you please advise how to start?

Thank you.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

