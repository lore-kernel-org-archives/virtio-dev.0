Return-Path: <virtio-dev-return-10755-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 7 Feb 2023 15:25:55 +0000
Message-ID: <PH0PR12MB54818BBB534E9E18B9B85E5BDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org>
 <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
 <20230207094403-mutt-send-email-mst@kernel.org>
 <CAJs=3_B8w0Eet5SvfODC2Xwj1rnMmhR2sZpHxjJ4JC=5jnv-xA@mail.gmail.com>
 <20230207095919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207095919-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists .
 oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists
 . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 7, 2023 10:09 AM
>=20
> On Tue, Feb 07, 2023 at 04:56:06PM +0200, Alvaro Karsz wrote:
> > > An example of a question is this: we have two RX queues say 1 and 2
> > > each with a distinct interrupt vector. coalescing is set to 10
> > > packets.  Now
> > > 9 packets arrive on queue 1 and 1 on queue 2. Do you expect an
> > > interrupt? If yes which one - 1 or 2 or both?
> >
> > Sorry, I wasn't clear enough.
> > In this case, you should not issue an interrupt until one of the
> > queues receives the 10'th packet.
> > The counters are per queue, the coalescing parameters (usecs and
> > max_packets) are global.
> >
Counters and parameters go hand-in hand.
It should be per VQ.

> > I agree that this should be mentioned in the spec, I missed it.
>=20
> Right. So in my humble opinion, ability to configure parameters per queue=
 is
> not completely free, as this is doubling the memory requirements.
> Sounds like a feature bit is somewhat justified. No?
>=20
> --
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

