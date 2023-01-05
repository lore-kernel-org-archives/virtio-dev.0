Return-Path: <virtio-comment-return-3685-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20221221101729.648097-1-alvaro.karsz@solid-run.com>
 <20230104095454-mutt-send-email-mst@kernel.org> <CAJs=3_D9ZmUxCpjMfKNSYdE5k65yPRF2Oq7x77w8qM-h8KdZbw@mail.gmail.com>
In-Reply-To: <CAJs=3_D9ZmUxCpjMfKNSYdE5k65yPRF2Oq7x77w8qM-h8KdZbw@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Thu, 5 Jan 2023 09:32:56 +0200
Message-ID: <CAJs=3_BK+NK6w1Rp-YD+BWTTxtXn_qrbQk8UyT+WQ3tUFON25Q@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH] virtio_net: support low and high rate of notification
 coalescing sets
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

> > is it really true we always want the same rate for tx and rx?
> > why not separate commands for each? this is the way we went
> > for general coalescing at least.
>
> I actually had ethtool in mind while writing the patch.
> AFAIK ethtool has a single rate for both rx and tx low/high, so using
> ethtool to manage the parameters won't be possible.
>
> I know that we should worry about that when trying to implement the
> feature and not while proposing it to the spec, but I think that we
> will benefit the most from this feature if it can be used with an
> existing, well known tool such as ethtool.
>
> What do you think?

ok, we actually could separate tx and rx, and send both commands when
ethtool is used to set low/high rate.
I will fix the patch to have different rx and tx commands.

Alvaro

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

