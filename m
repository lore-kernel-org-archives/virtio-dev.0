Return-Path: virtio-dev-return-7289-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCA06985E9A
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 May 2020 16:11:39 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 08 May 2020 17:11:36 +0100
Message-ID: <87sgga4daf.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] VIRTIO RPMB Front End drivers for Linux
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, Tomas Winkler <tomas.winkler@intel.com>, Yang Huang <yang.huang@intel.com>
Cc: Bing Zhu <bing.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

I'm currently working on a vhost-user backend for virto-rpmb as defined
in the draft version of the OASIS spec (since 8c6acac2). I'm developing
it within the QEMU source tree but it is intended to be a portable
vhost-user binary with minimal POSIX like dependencies.

Part of the aim of the project is to experiment with a vhost-user
backend that has minimal access to guest memory and RPMB makes sense as
the vhost-user daemon only really needs to see the virt queues to pass
the data back and forth. One eventual architecture would be to move the
vhost-user driver into it's own isolated VM with only minimal memory
sharing between the guest and it's back-end.

I've gotten enough of the plumbing working now that I'm ready to start
implementing the RPMB spec itself. I've been looking for a front-end to
use in testing and I found the Linux driver sitting in Project ACRN's
guest kernel fork. With this kernel and VIRTIO_ID_RPMB tweaked to the
standard based one I get far enough that the driver is initialised
before my drivers falls over when an un-handled feature is requested
(0x130000000). This is slightly confusing because the spec doesn't
define any feature bits. So a few questions:

  - how divergent is the virtio-rpmb front/back-end in ACRN from the
    OASIS spec?

  - is there likely to be another submission to the upstream kernel?

I've also read the document on the ACRN website which talks about the
secure architecture:

  https://projectacrn.github.io/latest/tutorials/trustyACRN.html

I was wondering if there was any low level usage information. From
looking at the Kconfig options it seems the virtio-rpmb driver
interfaces with a wider RPMB sub-system which exposes a character device
to the kernels user-space. So:

  - are there any special user-space tools to use this interface?

  - is there a write-up somewhere of how to exercise the interface or
    any sort of test suite?

Thanks in advance,


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

