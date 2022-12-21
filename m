Return-Path: <virtio-comment-return-3599-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1671631110.0888484-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 21 Dec 2022 21:58:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
 <1671620897.6449997-1-xuanzhuo@linux.alibaba.com>
 <CAJs=3_BJKqCRb6xJpcuR7U4SmHtO7QRFA1gtyiiPt2ik=rk9Sg@mail.gmail.com>
In-Reply-To: <CAJs=3_BJKqCRb6xJpcuR7U4SmHtO7QRFA1gtyiiPt2ik=rk9Sg@mail.gmail.com>
Subject: [virtio-comment] Re: [virtio-dev] [PATCH] virtio_net: support low and high rate of notification coalescing sets
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 21 Dec 2022 13:48:59 +0200, Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
> Hi,
>
> > I want to know which one is better than NetDim(Coalesce Adaptive) in driver.
> >
> > I know Heng Qi's work in this.
> >
> > Thanks
>
>
> Why choose? we can have both.
> ethtool can handle both pkt_rate_low/pkt_rate_high and
> use_adaptive_rx_coalesce/use_adaptive_tx_coalesce.
>
> The adaptive algorithm can even use this feature to set low and high
> coalescing sets.

Yes, I understand.

But if a function can be implemented on driver, we don't need to let the device
support it.

I hope that the device is simpler, if it is possible.

Thanks.

>
> Alvaro

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

