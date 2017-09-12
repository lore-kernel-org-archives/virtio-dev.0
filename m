Return-Path: virtio-dev-return-2535-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D5CA958191A0
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2017 09:24:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0f0e1b94-2a46-689c-dbb3-0d578cc8df33@redhat.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com> <0f0e1b94-2a46-689c-dbb3-0d578cc8df33@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 12 Sep 2017 12:23:56 -0400
Message-ID: <CAF=yD-+LtZO=Fcw6Y-v0dnxkmwqW1+CqzopyQEApOjOAszgqMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: packed ring layout proposal v3
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Sep 11, 2017 at 3:47 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B409=E6=9C=8810=E6=97=A5 13:06, Michael S. Tsirkin wrote:
>>
>> This is an update from v2 version.
>> Changes:
>> - update event suppression mechanism
>> - add wrap counter: DESC_WRAP flag in addition to
>>    DESC_DRIVER flag used for validity so device does not have to
>>    write out all used descriptors.
>
>
> Do we have benchmark result to show the advantage of DESC_DRIVER over e.g
> avail/used index?

The KVM forum presentation has some numbers.

I'm not sure that synthetic benchmarks will provide much value, as we
understand the trade-off quite well.

The benefit of this model is improved best case performance, by having
a single cacheline read instead of two for the indirect used/avail ring mod=
el.

The drawback is worse worst case, as scanning the ring of descriptors
introduces more cacheline misses than scanning the compressed
used/avail ring.

This model is easier to implement in hardware and the common case is
likely close to the best case, so I think it makes sense.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

