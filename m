Return-Path: <virtio-comment-return-4262-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230215095409.1119696-1-alvaro.karsz@solid-run.com>
 <m25yc3xcch.fsf@oracle.com>
 <CAJs=3_B9GNpgzj-75mhTm1CtVwa5JfhLzqzRjxD+bsinHOLVZA@mail.gmail.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Wed, 15 Feb 2023 16:56:07 +0000
In-reply-to: <CAJs=3_B9GNpgzj-75mhTm1CtVwa5JfhLzqzRjxD+bsinHOLVZA@mail.gmail.com>
Message-ID: <m2wn4ix3vn.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: Fix and update
 VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, hengqi@linux.alibaba.com, parav@nvidia.com, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On Wednesday, 2023-02-15 at 18:45:14 +02, Alvaro Karsz wrote:
>> > +\begin{note}
>> > +In general, these commands are best-effort: spurious notifications could still arrive.
>> > +\end{note}
>>
>> This is quite vague. How about:
>>
>> The behaviour of the device in response to these commands is
>> best-effort: the device may generate notifications more frequently than
>> specified, for example after less than \field{max_packets} packets have
>> been processed or less than \field{usecs} usecs time has elapsed.
>>
>
> On second thought, this may be a little confusing.
> The device can send a notification before processing max_packets
> packets, if usecs elapsed (and vice versa).
> So it should be "less than \field{max_packets} packets have been
> processed AND less than \field{usecs} usecs ..."
>
> How about dropping the example?

Given Parav's comment as well, drop the example, yes.
-- 
Don't worry, Mary, cause I'm taking care of Danny, and he's taking care of me.

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

