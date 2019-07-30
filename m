Return-Path: virtio-comment-return-825-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jul 2019 02:49:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190730023141-mutt-send-email-mst@kernel.org>
References: <1564386494-2296-1-git-send-email-yang.huang@intel.com>
 <1564386494-2296-2-git-send-email-yang.huang@intel.com>
 <20190729104802-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC4157267E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B92A36466FABC4D99BAF0BDB1FA8BBC4157267E@shsmsx102.ccr.corp.intel.com>
Subject: Re: [virtio-comment] Re: [PATCH] Add virtio rpmb device specification
To: "Huang, Yang" <yang.huang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jul 30, 2019 at 05:51:24AM +0000, Huang, Yang wrote:
> > > +\item The device MUST authenticate write operation by MAC calculated
> > > +   by authentication key and monotonic write counter .
> > 
> > authenticate how?
> 
> 1. compare the monotonic write counter in RPMB frame with the one recorded in device. Make sure the two values are equal. This counter protects from replay attack.
> 2. calculate the MAC by RPMB key(recorded by device at the first program key request from guest) and the RPMB frame received from driver. Compare this MAC with the MAC in RPMB frame. Make sure the two MACs are same. It protects data from tampering by the attacks who doesn't have RPMB key.
> After 1&2 are authenticated, a write operation will be performed.
> 
> Should include these details into spec?

Looks more like validation.

So if you add a conformance statement you need
to explain what is the device supposed to do.

E.g if you talk about write counter define what it is previously.



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

