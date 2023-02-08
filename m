Return-Path: <virtio-dev-return-10798-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A6A4C9860CB
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 13:54:17 +0000 (UTC)
Date: Wed, 8 Feb 2023 08:54:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208085359-mutt-send-email-mst@kernel.org>
References: <7ea229af-56b9-602e-c6f9-0225a95b1156@gmail.com>
 <fac470d2-a4c3-c2e0-7a70-31a141378ac3@opensynergy.com>
 <3301b22a-bb1f-81e0-1c90-87e964fa4a85@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3301b22a-bb1f-81e0-1c90-87e964fa4a85@gmail.com>
Subject: Re: [virtio-dev] VirtIO Sound (audio control support)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Sameer Pujar <dev.spujar@gmail.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 07:21:45PM +0530, Sameer Pujar wrote:
> Thanks Anton for your response.
> 
> 
> On 08-02-2023 18:46, Anton Yakovlev wrote:
> > Hi Sameer,
> > 
> > We were waiting for the extension for audio controls to be accepted into
> > the
> > VIRTIO specification.
> 
> Is audio control extension proposal to VIRTIO sound specification accepted?

Is this it?

commit 49ff7805924c421a0ca06e75d1741e0216c8f11c
Author: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Date:   Tue Apr 20 20:32:03 2021 +0200

    virtio-snd: add support for audio controls
    
    This patch extends the virtio sound device specification by adding
    support for audio controls. Audio controls can be used to set the volume
    level, mute/unmute the audio signal, switch different modes/states of
    the virtual sound device, etc.
    
    Fixes: https://github.com/oasis-tcs/virtio-spec/issues/107
    
    Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
    Signed-off-by: Cornelia Huck <cohuck@redhat.com>



> > We recently resumed our upstreaming efforts and a
> > colleague of mine should resubmit the patch soon.
> > 
> > 
> 
> I will look forward to it and can probably help in testing this.
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

