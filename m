Return-Path: <virtio-dev-return-9340-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C50C298647B
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 13:45:41 +0000 (UTC)
Date: Tue, 1 Mar 2022 08:45:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220301084433-mutt-send-email-mst@kernel.org>
References: <20220301120021.147070-1-stefanha@redhat.com>
 <Yh4it+8MroTwbnlz@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <Yh4it+8MroTwbnlz@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document that the capacity field can change
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 01, 2022 at 01:42:15PM +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 01, 2022 at 12:00:21PM +0000, Stefan Hajnoczi wrote:
> > Block devices can change size during operation. A configuration change
> > notification is sent by the device and the driver detects that the field
> > has changed. Document this behavior that has already been implemented in
> > Linux and QEMU since 2011.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  content.tex | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> Requesting a vote.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/136

We can vote but not for 1.2 unless it's urgent (i.e. a regression), and
I think we can wait with this one.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

