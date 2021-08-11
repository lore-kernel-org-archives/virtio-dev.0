Return-Path: <virtio-dev-return-8513-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA31098606D
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Aug 2021 10:05:58 +0000 (UTC)
Date: Wed, 11 Aug 2021 15:35:50 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Message-ID: <20210811100550.GC21582@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>
 <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
MIME-Version: 1.0
In-Reply-To: <09b74816-8a1e-f993-640f-eb790a4a4698@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in
 driver during reset
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok
 Soni <quic_tsoni@quicinc.com>, Pratik Patel <quic_pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Jason Wang <jasowang@redhat.com> [2021-08-02 14:06:38]:

> >Maybe if it sees status was not read it can just
> >stay in reset state and not exit it?
> >
> >
> 
> Or I wonder we can use increase the version instead.

What should be the guidance for backend/devices here? Go with version 3 only if
it requires driver to poll on reset? Otherwise it may break existing setups -
lets say Qemu is updated to report version 3 which will break older guest images
that understood version 2 - this is despite the same Qemu being capable of
serving those guests.

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

