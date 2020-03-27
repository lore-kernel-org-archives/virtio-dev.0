Return-Path: virtio-comment-return-1171-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20200227113735.23605-1-peter.hilber@opensynergy.com>
 <20200317192053.15665-1-peter.hilber@opensynergy.com>
 <87blonas8y.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87blonas8y.fsf@linaro.org>
Date: Fri, 27 Mar 2020 14:43:37 +0000
Message-ID: <87h7y9n9ie.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio-dev] [PATCH v3] Add virtio SCMI device specification
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Peter Hilber <peter.hilber@opensynergy.com>
Cc: virtio-comment@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Hilber <peter.hilber@opensynergy.com> writes:
>
>> This patch proposes a new virtio device for the Arm SCMI protocol.
>>
>> The device provides a simple transport for the Arm SCMI protocol[1]. The
>> *S*ystem *C*ontrol and *M*anagement *I*nterface protocol allows speaking
>> to system controllers that allow orchestrating things like power
>> management, system state management and sensor access. The SCMI protocol
>> is used on SoCs where multiple cores and co-processors need access to
>> these resources.
>>
> <snip>
>>
>> OpenSynergy has a prototype implementation (without device specific
>> features so far), and plans to upstream the Linux kernel driver.
>
> Has a RFC of the kernel driver been posted yet? I'm curious on how it
> Linux backend integrates with other devices.
>
>>
>> The PDF output is available at [2].
>>
>> [2]
>> https://share.mailbox.org/ajax/share/056076e70571144f50c4ca7571144b319a1=
d7236dda1cd3b/1/8/MzQ/MzQvMQ
>
> This PDF seems to include a fair number of extra devices - including an
> RPMB device I'm quite interested in. Is this because you are building
> from a tree with a bunch of rolled up updates?

I obviously failed to appropriately grep the existing spec closely
enough :-/

> /me wonders off to look at the make tooling in the upstream repo to see
> if things can be tweaked a bit.

I went ahead and suggested some tweaks anyway.

--=20
Alex Benn=C3=A9e

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

