Return-Path: <virtio-dev-return-10490-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7584F986421
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jan 2023 17:16:42 +0000 (UTC)
Date: Mon, 9 Jan 2023 12:16:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230109121558-mutt-send-email-mst@kernel.org>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-2-parav@nvidia.com>
 <20230109083745-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v1 01/20] virtio-network: Maintain network device spec in
 separate directory
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 09, 2023 at 02:12:36PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, January 9, 2023 8:43 AM
> > 
> > I found another issue with this. Currently for redline diff generation
> > we use latexpand. Using a flat expanded file has lots of benefits, in
> > particular latexdiff is sometimes fragile as it is, with a flat file
> > one can at least see the input it gets.
> > 
> > We should either stick with \\input or more work is needed on
> > these scripts. Besides, we are already using \\input and I like
> > consistency.
> > 
> > So my preference is \\input for now.
> \\input doesn't support reading from the directory.

In that case let's put everything in the same directory.
The argument for splitting things was weak anyway.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

