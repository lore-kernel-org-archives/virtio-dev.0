Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9715666D
	for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973357; cv=none; b=supXPEfDCQ0YzYQD2GI7cwvHF186oOGvLG+iNC2f2qiDjNaTyJuQcK1YFwdNeCJNjgkolSMD0gkVn5ZkjeKucVfnfp3BRdKgAenVMsJlaNy6jOl5Ke0e/ufDj8Yt5B60UTc7aJw9cw+hlr4woUvKLLxpdRn4besNXlsO04yLxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973357; c=relaxed/simple;
	bh=fkYfLB7BkpI4W3EQOlvtcDUJr9taWUaCe/cQpnY7uc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tgysXtaVNbI3K+TPgxTH8IQLYMjqXSkdD/GrxiSdFuivsQe3XElLjf3/hJGV813Fq0ljj+uG97rJsKRrIucEpH6CgIc2Y05U5uOopccRkyRDNuNAa8Pm252oRwsj/f8mcTuuB0iV/Lq6uJW2jZcu3oErvzOslbEW3w0/3LwapT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGimcAzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGimcAzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721973355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
	b=cGimcAzf3xltsd0XRuxyvFkv7JpJnEpo9xmQY4BBo3w0Xqd2sqBTrQDRSyJXpJ7hMbOgT5
	Cqs8WHwrPKGlW40uWvg+Ufbp6rz8Jo0u7b45KzG2tWAhBthTTl1uShTugI6Nzrfp9FvZwE
	c3h1lPZNVPHm++waKdG5qHnVLma42iE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-wFtPj_mVNPWKnrWJdDRV4g-1; Fri, 26 Jul 2024 01:55:53 -0400
X-MC-Unique: wFtPj_mVNPWKnrWJdDRV4g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280291f739so12728095e9.3
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 22:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973352; x=1722578152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQThcy6xed9kn8EJsXisAuikWbZtGIN23SlH2PNZkcA=;
        b=CgBfm6hGXChZG1bhPhccUMPLAbyXwEl8T/8hiXbimMNm0BYN/xcTeeWvUpr8vRV9rK
         UCo79HBWik2T07Nm+eDM3OUUtJR8sbQYx2QNTTTY/Amm36dhdAYLaeg5T88vZ4fHoBtp
         PviWOjL8oeiurp01QXKtnVN2yxRDA7YJIo1bT0WSJG+ZPpJA0wcXDBe5VaUo/ozu5IKs
         H/vBQAq+oAZVkmlpJT5M8Ewy6+HVJGTc9HsmDfaKw+RsRgiDtdb4geJhxTFFohRGEpVd
         IcFbkcGVFwRYkrzckpcZScxS9ZVb+SxBV4dzQsqZA+FzGnni0Pc7Y3sOgHcFS48kf8vJ
         /lXw==
X-Forwarded-Encrypted: i=1; AJvYcCW5mr3rz2GiaNDSo/6SnoSS2W0B3DjFEIJmlsAkKsZnXd4i5MbwQZ/vaVbVePAyB1rmQzjc3WOqDnu0OHElxMqesG5XilEE952JFg==
X-Gm-Message-State: AOJu0YwaFX7vDKKrRE8MfMWeHviEn7b8g0w4AVn7bDDFIEYud3QTJnd/
	If2d5OMTIFMITorb79PtmT1XK1BGALFr9L5YIHeoVn1e8EPlHCsvVyo7Kh5ohsg5t1a7WEJe7o5
	dF0Le+MFzc80GPhG6ptG8Fh4WKmqzTuzaGueGDfN8neURENzqiwRYuO+9ZX0=
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-36b31ae2541mr2973091f8f.23.1721973351676;
        Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwUk9Ft0dVUiNjmu7f1QTIXu6q3o+g6VMlVMK1lSks1buGboeYtzHjiLlkzq1mSCBI88a7sA==
X-Received: by 2002:adf:c08b:0:b0:367:8875:dd4c with SMTP id ffacd0b85a97d-36b31ae2541mr2973059f8f.23.1721973351027;
        Thu, 25 Jul 2024 22:55:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280573edbfsm63673365e9.15.2024.07.25.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:55:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Chashper, David" <chashper@amazon.com>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Christopher S . Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	netdev@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	qemu-devel <qemu-devel@nongnu.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] ptp: Add vDSO-style vmclock support
Message-ID: <20240726012933-mutt-send-email-mst@kernel.org>
References: <98813a70f6d3377d3a9d502fd175be97334fcc87.camel@infradead.org>
 <20240725100351-mutt-send-email-mst@kernel.org>
 <2a27205bfc61e19355d360f428a98e2338ff68c3.camel@infradead.org>
 <20240725122603-mutt-send-email-mst@kernel.org>
 <0959390cad71b451dc19e5f9396d3f4fdb8fd46f.camel@infradead.org>
 <20240725163843-mutt-send-email-mst@kernel.org>
 <d62925d94a28b4f8e07d14c1639023f3b78b0769.camel@infradead.org>
 <20240725170328-mutt-send-email-mst@kernel.org>
 <c5a48c032a2788ecd98bbcec71f6f3fb0fb65e8c.camel@infradead.org>
 <20240726010511-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240726010511-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 01:09:24AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 25, 2024 at 10:29:18PM +0100, David Woodhouse wrote:
> > > > > Then can't we fix it by interrupting all CPUs right after LM?
> > > > > 
> > > > > To me that seems like a cleaner approach - we then compartmentalize
> > > > > the ABI issue - kernel has its own ABI against userspace,
> > > > > devices have their own ABI against kernel.
> > > > > It'd mean we need a way to detect that interrupt was sent,
> > > > > maybe yet another counter inside that structure.
> > > > > 
> > > > > WDYT?
> > > > > 
> > > > > By the way the same idea would work for snapshots -
> > > > > some people wanted to expose that info to userspace, too.
> > 
> > Those people included me. I wanted to interrupt all the vCPUs, even the
> > ones which were in userspace at the moment of migration, and have the
> > kernel deal with passing it on to userspace via a different ABI.
> > 
> > It ends up being complex and intricate, and requiring a lot of new
> > kernel and userspace support. I gave up on it in the end for snapshots,
> > and didn't go there again for this.
> 
> Maybe become you insist on using ACPI?
> I see a fairly simple way to do it. For example, with virtio:
> 
> one vq per CPU, with a single outstanding buffer,
> callback copies from the buffer into the userspace
> visible memory.
> 
> Want me to show you the code?

Couldn't resist, so I wrote a bit of this code.
Fundamentally, we keep a copy of the hypervisor abi
in the device:

struct virtclk_info *vci {
	struct vmclock_abi abi;
};

each vq will has its own copy:

struct virtqueue_info {
	struct scatterlist sg[];
	struct vmclock_abi abi;
}

we add it during probe:
        sg_init_one(vqi->sg, &vqi->abi, sizeof(vqi->abi));
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vq->vabi,
                        GFP_ATOMIC);



We set the affinity for each vq:

       for (i = 0; i < num_online_cpus(); i++)
               virtqueue_set_affinity(vi->vq[i], i);

(virtio net does it, and it handles cpu hotplug as well)

each vq callback would do:

static void vmclock_cb(struct virtqueue *vq)
{
        struct virtclk_info *vci = vq->vdev->priv;
        struct virtqueue_info *vqi = vq->priv;
	void *buf;
        unsigned int len;

	buf = virtqueue_get_buf(vq, &len);
	if (!buf)
		return;

	BUG_ON(buf != &vq->abi);

	spin_lock(vci->lock);
	if (memcmp(&vci->abi, &vqi->abi, sizeof(vqi->abi))) {
		memcpy(&vci->abi, &vqi->abi, sizeof(vqi->abi));
	}

	/* Update the userspace visible structure now */
	.....

	/* Re-add the buffer */
	virtqueue_add_inbuf(vq,
                        vqi->sg, 1,
                        &vqi->abi,
                        GFP_ATOMIC);

	spin_unlock(vi->lock);
}

That's it!
Where's the problem here?

-- 
MST

