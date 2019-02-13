Return-Path: virtio-dev-return-5421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C34EC985E0B
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 02:04:41 +0000 (UTC)
Date: Tue, 12 Feb 2019 21:04:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212205956-mutt-send-email-mst@kernel.org>
References: <20190213013813.GA14307@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213013813.GA14307@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: Requesting ballots for #31 and #32
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 13, 2019 at 09:38:13AM +0800, Stefan Hajnoczi wrote:
> Hi,
> I'd like to request ballots for the following issues:
> 
> "content: reserve virtio device ID for file system devices"
> https://github.com/oasis-tcs/virtio-spec/issues/31
> 
> "virtio-blk: discard and write zeroes clarifications"
> https://github.com/oasis-tcs/virtio-spec/issues/32
> 
> At least #32 is needed for VIRTIO 1.1 but #31 is trivial and will
> prevent device ID conflicts so I suggest merging it too.
> 
> Thank you,
> Stefan

Would you say that #32 is a material change or not?

	"Material Change" is any change to the content of a Work Product that
	that would require a compliant application or implementation to be
	modified or rewritten in order to remain compliant or which adds new
	features or otherwise expands the scope of the work product.

I think you indicated in the past that it isn't.

However I think #31 would be a new feature. If yes including it would not
qualify as non material change and that would force
another public review round.

Would you agree?
If doesn't seem worth forcing a public review for a trivial change.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

