Return-Path: <virtio-dev-return-8555-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F7D5986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 05:15:53 +0000 (UTC)
Date: Wed, 18 Aug 2021 10:45:44 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20210818051544.GC9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
 <20210811100550.GC21582@quicinc.com>
 <2723b42a-f5d0-9c49-bf5c-302fbd4c947f@redhat.com>
 <20210816013138-mutt-send-email-mst@kernel.org>
 <20210816063550.GD5604@quicinc.com>
 <20210816074558-mutt-send-email-mst@kernel.org>
 <af73ed7b-b339-3ba2-87cb-176a9435fa2c@redhat.com>
 <20210817034312-mutt-send-email-mst@kernel.org>
 <20210817100333.GA9207@quicinc.com>
 <e07fd648-9044-d486-29b6-83ee64b6842a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e07fd648-9044-d486-29b6-83ee64b6842a@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Jason Wang <jasowang@redhat.com> [2021-08-18 10:54:37]:

> >I think the option we discussed earlier of a new feature bit seems less
> >intrusive than incrementing MMIO version?
> >
> >https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html
> 
> 
> Using features will result some interesting question:
> 
> 1) the drivers usually reset the device before feature negotiation
> 2) it means the driver must mandate this behavior even before feature
> negotiation is done
> 
> We don't have those issue if we increase the version (but it looks more
> intrusive).

Hmm ..are you suggesting that we read the Version register as part of reset code
and do the wait part only for v3 device? Otherwise we have the same issue as
feature bit with version change also. 

Can't the driver do the same with feature register also? Do poll if
WAIT_FOR_RESET_COMPLETION feature bit is set, which can happen before feature
negotiation is complete.

- vatsa

-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

