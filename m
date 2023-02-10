Return-Path: <virtio-comment-return-4127-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 10 Feb 2023 04:39:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230210043841-mutt-send-email-mst@kernel.org>
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <20230210031041-mutt-send-email-mst@kernel.org>
 <CAJs=3_Bz_NECj4nUtu5es=UECD9c1FAKy1SFtKrve8BL4KDDVA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_Bz_NECj4nUtu5es=UECD9c1FAKy1SFtKrve8BL4KDDVA@mail.gmail.com>
Subject: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue coalescing
 moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 10, 2023 at 11:30:40AM +0200, Alvaro Karsz wrote:
> > >  \devicenormative{\subparagraph}{Notifications Coalescing}{Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
> > >
> > > -A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters.
> > > +A device SHOULD respond to the VIRTIO_NET_CTRL_NOTF_COAL commands with VIRTIO_NET_ERR if it was not able to change the parameters or
> > > +was not able to find a virtqueue using the \field{vqn}.
> >
> > First please create multiple statements not a single long one.
> > Second vqn only exists for per vq commands so create a statement
> > just for that.
> > Also more explicit please. What does this mean? I suspect that vq was not
> > enabled?
> > Also, we MUST have vqn < max_virtqueue_pairs.
> >
> 
> I believe that you meant  vqn < max_virtqueue_pairs * 2

Yes thanks!
Just pls snip to just the text you qoute to just relevant parts -
I had to scroll like 300 lines to get to the relevant one :)


-- 
MST


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

