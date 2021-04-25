Return-Path: virtio-dev-return-8141-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A96BC983C43
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Apr 2021 07:13:59 +0000 (UTC)
Date: Sun, 25 Apr 2021 03:13:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210425031325-mutt-send-email-mst@kernel.org>
References: <777659BA-5535-4EEA-A0C1-C39380BF587E@holtmann.org>
 <20210423162440-mutt-send-email-mst@kernel.org>
 <F6E12E6D-7F1C-41F1-96A1-838CD2D524CC@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F6E12E6D-7F1C-41F1-96A1-838CD2D524CC@holtmann.org>
Subject: Re: [virtio-dev] Reserve device id for Bluetooth device
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Marcel Holtmann <marcel@holtmann.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Apr 24, 2021 at 09:05:37AM +0200, Marcel Holtmann wrote:
> Hi Michael,
> 
> >> I like to reserve device ID 40 for Bluetooth device. Thanks.
> >> 
> >> Regards
> >> 
> >> Marcel
> > 
> > The easiest way to do this is by sending a patch with
> > the proposed change:
> > https://github.com/oasis-tcs/virtio-spec#providing-feedback
> > and then request approval by creating a github issue:
> > https://github.com/oasis-tcs/virtio-spec#use-of-github-issues
> 
> I would have done that, but there are actually missing ID numbers in the current git tree and one outstanding patch.
> 
> The conclusion was that 40 is the next free number.
> 
> Regards
> 
> Marcel

that's ok, just send a patch reserving 40. they don't have to be
sequential.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

