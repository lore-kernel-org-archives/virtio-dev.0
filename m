Return-Path: virtio-dev-return-6232-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE063984017
	for <virtio-dev@lists.oasis-open.org>; Sun, 13 Oct 2019 17:48:11 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9c7a1f52-c9bf-7360-557f-3b5a53ea2b9e@siemens.com>
Date: Sun, 13 Oct 2019 19:48:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] virtio-console: initial size retrieval, port parameter reporting
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all,

while implementing a basic virtio-console backend, I noticed some grey
area regarding when and how the initial console size should be read by
the driver.

Linux currently only does that sizing when the device signals a config
change, either via a config interrupt (non-multiport) or by sending a
VIRTIO_CONSOLE_RESIZE control message. But the spec is not clear whether
a device is supposed to do exactly that.

Let's look at the two cases, first without VIRTIO_CONSOLE_F_MULTIPORT:
I would have expected that the driver can find the console size in the
configuration early, even before FEATURES_OK. And I would have expected
that Linux evaluates that value during probe. Again, the spec does not
tell us whether the device must send that initial config update to
declare the size information valid.

Now with VIRTIO_CONSOLE_F_MULTIPORT:
Here, the device can only signal the dimensions for ports > 0 via a
control message. This suggests (but the spec does not state it
explicitly) that the device will likely send VIRTIO_CONSOLE_RESIZE
message after VIRTIO_CONSOLE_PORT_READY. And that also for port 0,
although its size is available also via the config. BTW, is a device in
that case also supposed to signal a config change? Or should a device
never offer F_MULTIPORT and F_SIZE at the same time?

In general, the spec does not state when a device should (or rather
must) send any of the _CONSOLE_PORT, _RESIZE and _PORT_NAME messages. I
assume they are meant to be sent after _PORT_READY from the driver
because the spec says:

"After creating and initializing each port, a VIRTIO_CONSOLE_PORT_READY
control message is sent to the device for that port so the device can
let the driver know of any additional configuration options set for that
port."

If my assumption is correct, that ordering should be stated more
explicitly in the spec.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

