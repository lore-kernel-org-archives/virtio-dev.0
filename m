Return-Path: virtio-dev-return-3959-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2891F5818E24
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 15:25:31 -0700 (PDT)
Date: Thu, 26 Apr 2018 01:25:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180426012341-mutt-send-email-mst@kernel.org>
References: <1524071419-32187-1-git-send-email-jonathan.helman@oracle.com>
 <20180419092433.GA4327@stefanha-x1.localdomain>
 <f3662a7f-df86-f176-fc03-9ef9815e32b8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3662a7f-df86-f176-fc03-9ef9815e32b8@oracle.com>
Subject: Re: [virtio-dev] [PATCH] content: document hugetlb page allocation
 counts
To: Jonathan Helman <jonathan.helman@oracle.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, mihai.carabas@oracle.com, jasowang@redhat.com, Thomas Tai <thomas.tai@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 25, 2018 at 11:26:59AM -0700, Jonathan Helman wrote:
> 
> 
> On 04/19/2018 02:24 AM, Stefan Hajnoczi wrote:
> > On Wed, Apr 18, 2018 at 10:10:19AM -0700, Jonathan Helman wrote:
> > > The Linux kernel exports the number of successful and failed
> > > hugetlb page allocations via the virtio balloon driver. These
> > > two counts need to be documented in this specification.
> > > 
> > > Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> > > ---
> > >   content.tex | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> Thanks. Do I need to take some action, like adding a tag to the github issue
> I opened?
> 
> Jon

Just what you did: ask for voting to start.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

