Return-Path: <virtio-comment-return-4006-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1675821486.1692133-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 8 Feb 2023 09:58:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org>
 <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
 <20230207094403-mutt-send-email-mst@kernel.org>
 <CAJs=3_B8w0Eet5SvfODC2Xwj1rnMmhR2sZpHxjJ4JC=5jnv-xA@mail.gmail.com>
 <20230207095919-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BBB534E9E18B9B85E5BDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207102714-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207102714-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net: support per-queue coalescing moderation
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 7 Feb 2023 10:28:37 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Feb 07, 2023 at 03:25:55PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, February 7, 2023 10:09 AM
> > >
> > > On Tue, Feb 07, 2023 at 04:56:06PM +0200, Alvaro Karsz wrote:
> > > > > An example of a question is this: we have two RX queues say 1 and 2
> > > > > each with a distinct interrupt vector. coalescing is set to 10
> > > > > packets.  Now
> > > > > 9 packets arrive on queue 1 and 1 on queue 2. Do you expect an
> > > > > interrupt? If yes which one - 1 or 2 or both?
> > > >
> > > > Sorry, I wasn't clear enough.
> > > > In this case, you should not issue an interrupt until one of the
> > > > queues receives the 10'th packet.
> > > > The counters are per queue, the coalescing parameters (usecs and
> > > > max_packets) are global.
> > > >
> > Counters and parameters go hand-in hand.
> > It should be per VQ.
>
> Well you could have a global parameter and per queue counter.

The global parameter configuration I understand is to configure the counter
of all queues to the same value through a command.

Thanks.


> In fact ethtool only has a global parameter support - how
> will users configure per-queue ones?
>
> > > > I agree that this should be mentioned in the spec, I missed it.
> > >
> > > Right. So in my humble opinion, ability to configure parameters per queue is
> > > not completely free, as this is doubling the memory requirements.
> > > Sounds like a feature bit is somewhat justified. No?
> > >
> > > --
> > > MST
>

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

