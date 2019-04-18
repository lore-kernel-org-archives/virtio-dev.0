Return-Path: virtio-dev-return-5670-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB5E8985EC8
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Apr 2019 04:39:17 +0000 (UTC)
Date: Thu, 18 Apr 2019 00:39:15 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <943759229.22370968.1555562355322.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190415135439.GF29134@stefanha-x1.localdomain>
References: <20190412050306.31874-1-pagupta@redhat.com> <20190415135439.GF29134@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH] content: reserve device ID for
 virtio-pmem devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


Hi Stefan,

Thank you for the review. 

After sending this patch I realized device ID 26 is already requested
by virtio-fs. So, I sent a v2[1] with a request to reserve id 27.
Could you please review this.

[1]
[PATCH v2] content: reserve device ID for virtio-pmem devices


Thanks,
Pankaj 

> 
> On Fri, Apr 12, 2019 at 10:33:06AM +0530, Pankaj Gupta wrote:
> > We need a device ID for virtio-pmem devices. As 25 is
> > requested by audio device, so requesting next available(26).
> > Also, updated the previously requested github issue[1] for
> > voting.
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  content.tex | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

