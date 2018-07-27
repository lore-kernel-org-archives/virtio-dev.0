Return-Path: virtio-dev-return-4751-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE07E985CA4
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 13:03:16 +0000 (UTC)
Date: Fri, 27 Jul 2018 16:03:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180727160035-mutt-send-email-mst@kernel.org>
References: <1532536840-48601-1-git-send-email-sridhar.samudrala@intel.com>
 <20180727145859.4cbb0f5e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727145859.4cbb0f5e.cohuck@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3] content: Introduce VIRTIO_NET_F_STANDBY feature
To: Cornelia Huck <cohuck@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 27, 2018 at 02:58:59PM +0200, Cornelia Huck wrote:
> On Wed, 25 Jul 2018 09:40:40 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> > device to act as a standby for another device with the same MAC address.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
> 
> (missing closing bracket)
> 
> > ---
> >  content.tex | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> While we certainly need to add more details later, I think we should
> just go ahead with this now as it at least gives some basic information
> about the merged feature.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Sounds good. Sridhar, for voting to proceed, you need to open a github
issue, then repost the patch with acks callected and including header
Fixes: <issue url>

Ideally you would put something like [PATCH voting-proposal] in the subject but we
did not yet standardize on this.
Thanks!

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

