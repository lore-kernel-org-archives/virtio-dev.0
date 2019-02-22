Return-Path: virtio-dev-return-5511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73D869860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 14:31:19 +0000 (UTC)
Date: Fri, 22 Feb 2019 14:31:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190222143101.GE2574@work-vm>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220124613.22661-2-stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:

> +It is possible to maintain the FUSE session across live migration either by
> +transferring the state or by redirecting requests from the new host to the old
> +host where the state resides.  The details of how to achieve this are
> +implementation-dependent and are not visible at the device interface level.

I wonder how 'transferring the state' will work;  it is tricky to
specify because that state could be filesystem dependent so wouldn't
really fit at this level of spec.

Dave

> -- 
> 2.20.1
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

