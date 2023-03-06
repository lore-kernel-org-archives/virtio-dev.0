Return-Path: <virtio-dev-return-11463-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121F5C64EC4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:57:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7738D42B71
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:57:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 700889866C9
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:57:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 64BA39866BE; Mon,  6 Mar 2023 22:57:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 527B09866BF
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 22:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mQZ1xRvAOnuUXfKeBWIJ5A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EdQ/FEnCRLg+zMLHSEvk+TGzODD4tqf8B4U6kjam8w=;
        b=BKpfawAF0tDgF9V/MnAH6Obb/q8W5sddj04gDrxhN80ulW593X635xuU7lXHvK/iKa
         dXwnP2S168a1KySig7fxl8yUG/siy9o5tln6EDwJJ0G5lPDlTVfxBFvIJBrqU4WCATxh
         EmFvZmkdeksrZOaTg0TEUlLi/cOdP0OXHS9YwqJMXMHd/KwpzlTGLl27CXyGgD1elNcu
         XCvJq4b1RjtDtoQvW0Wz8CAlaDtY65jTKVWEjoeHIImlhbxiN1gmJsB9i/nhFpy9cVOs
         Nha8TmGccNQVnY4HmdqBl9nxP/LztU71owuPAASeI+R2sXyiRaqoJePaoXFLAmUEvlLs
         VVsA==
X-Gm-Message-State: AO0yUKWaAm/fbXN1OqHFXn6Jkp9WxFmUNGv8xDzUvCmKopqPWvntO7pl
	HvPfKZ0GZG0KG5hwfuXhoL2KeEKvVCiOrtwqTIOXqcfYZREEkP/Wl7fXL/sTuNDC1EZLiwI0x0u
	zMjx1zYdjrG5fDsvnt02AERq12Wf8
X-Received: by 2002:adf:fbc7:0:b0:2cc:4d13:908d with SMTP id d7-20020adffbc7000000b002cc4d13908dmr7689872wrs.11.1678143430484;
        Mon, 06 Mar 2023 14:57:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8S5U0aWES8g6zNNn2q2NYBO3ZOm+8Jwy8sq+bGUUu7oUpd44jz7ovrjqleZu7TpCzCMmfakA==
X-Received: by 2002:adf:fbc7:0:b0:2cc:4d13:908d with SMTP id d7-20020adffbc7000000b002cc4d13908dmr7689863wrs.11.1678143430196;
        Mon, 06 Mar 2023 14:57:10 -0800 (PST)
Date: Mon, 6 Mar 2023 17:57:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	virtio-comment@lists.oasis-open.org
Message-ID: <20230306175558-mutt-send-email-mst@kernel.org>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <m2lekf1iq8.fsf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <m2lekf1iq8.fsf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation

On Thu, Mar 02, 2023 at 11:36:18AM +0000, David Edmondson wrote:
> > +                                        for an enabled transmit/receive virtqueue whose number is \field{vqn}.
> 
> Should this now be "whose index is \field{vqn}"?

Ugh.  I guess we'll have to fix the number/index mess in the spec
first. Parav you said you are looking into it?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

