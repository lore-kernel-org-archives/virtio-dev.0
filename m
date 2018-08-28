Return-Path: virtio-dev-return-4809-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BF8B985EA4
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Aug 2018 12:13:44 +0000 (UTC)
Date: Tue, 28 Aug 2018 08:13:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180828081248-mutt-send-email-mst@kernel.org>
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180827104035.4f9cf9ed.cohuck@redhat.com>
 <20180827153353-mutt-send-email-mst@kernel.org>
 <cc8c8043-a8b3-de92-9798-a61879b280da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8c8043-a8b3-de92-9798-a61879b280da@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v4] content: Introduce
 VIRTIO_NET_F_STANDBY feature
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Aug 27, 2018 at 09:50:33AM -0700, Samudrala, Sridhar wrote:
> On 8/27/2018 5:34 AM, Michael S. Tsirkin wrote:
> > On Mon, Aug 27, 2018 at 10:40:35AM +0200, Cornelia Huck wrote:
> > > On Wed, 15 Aug 2018 11:49:15 -0700
> > > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> > > 
> > > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> > > > device to act as a standby for another device with the same MAC address.
> > > > 
> > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
> > > I think you need to update the github issue to point to this (v4) patch.
> 
> Updated the github issue with link to v4 patch.

Please verify it's the same link that was put in the ballot:
https://www.oasis-open.org/committees/ballot.php?id=3240

> > > 
> > > > ---
> > > >   content.tex | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > Other than that, I'd vote (...) to start voting on this issue, but
> > > AFAIK I can't do that. Michael?
> > OK, ballot started.
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

