Return-Path: virtio-dev-return-6973-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C890F98433F
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Mar 2020 17:36:02 +0000 (UTC)
References: <20200227113735.23605-1-peter.hilber@opensynergy.com>
 <20200317192053.15665-1-peter.hilber@opensynergy.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200317192053.15665-1-peter.hilber@opensynergy.com>
Date: Mon, 23 Mar 2020 17:35:57 +0000
Message-ID: <87blonas8y.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3] Add virtio SCMI device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Peter Hilber <peter.hilber@opensynergy.com> writes:

> This patch proposes a new virtio device for the Arm SCMI protocol.
>
> The device provides a simple transport for the Arm SCMI protocol[1]. The
> *S*ystem *C*ontrol and *M*anagement *I*nterface protocol allows speaking
> to system controllers that allow orchestrating things like power
> management, system state management and sensor access. The SCMI protocol
> is used on SoCs where multiple cores and co-processors need access to
> these resources.
>
<snip>
>
> OpenSynergy has a prototype implementation (without device specific
> features so far), and plans to upstream the Linux kernel driver.

Has a RFC of the kernel driver been posted yet? I'm curious on how it
Linux backend integrates with other devices.

>
> The PDF output is available at [2].
>
> [2]
> https://share.mailbox.org/ajax/share/056076e70571144f50c4ca7571144b319a1d=
7236dda1cd3b/1/8/MzQ/MzQvMQ

This PDF seems to include a fair number of extra devices - including an
RPMB device I'm quite interested in. Is this because you are building
from a tree with a bunch of rolled up updates?

In fact looking closer at the rendered version it seems to be missing
device id 32.

/me wonders off to look at the make tooling in the upstream repo to see
if things can be tweaked a bit.

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

