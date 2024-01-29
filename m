Return-Path: <virtio-dev-return-14282-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654CEC47DDB
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 10:35:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A89CC2AF8B
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 10:35:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 88D7B986879
	for <virtio-dev@archiver.kernel.org>; Mon, 29 Jan 2024 10:35:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6ED9B983F75; Mon, 29 Jan 2024 10:35:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D821986870
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jan 2024 10:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524544; x=1707129344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVC6F8wHFbFQvQp6baCm2iGQFcC7xN9jHunt9qezSvQ=;
        b=brPO4mAPavlv+ZuztTsPJQcPRZVxVfY/mK2A+qTIs2FIIxnS/o174kN8oZ4cQN/IsO
         GA3itnONCP/tB8DHNuzSN2OF1QM788n91yLtE0rV2uy2G2bn5ZXKl2RFKFgpQKKoWY5k
         xsTWHTDeGdKhrdCWYcyM943BVZHXBGTHW6xJGE74uTkwjU7kINd3666KLCeCvsoQbQ2I
         c9g9LPTX6OEHN2yiDc99Npqy+eXeSgE7v4vcN6wk2wNxHFkOStgHx6nIltWvOTlpN1f0
         DAxgJvq78ecqr4QlAgV5CB21srOd3B7lxKmqIDV8kMNN61MY787Wv//hc34+lnRVWOJg
         CbRQ==
X-Gm-Message-State: AOJu0YwxuETatgfw0n0i8LeCq98+pjG8rN5BpkoCbKZKDSL1eXxkLLNO
	NxsodN6F06LaFYNxTzoM8VB7gG/chrm+B8bHjVKqnEFh5pT4+/hHHdOFIWhHkxI=
X-Google-Smtp-Source: AGHT+IHUCJNVe4KlE+eXILwXdrEFSyRExoSnpNWrh2dmWyNzDE9m41dapGhs0DQCyDCR8RsK83hIVw==
X-Received: by 2002:a25:26d2:0:b0:dbe:9509:141c with SMTP id m201-20020a2526d2000000b00dbe9509141cmr2103709ybm.30.1706524544225;
        Mon, 29 Jan 2024 02:35:44 -0800 (PST)
Date: Mon, 29 Jan 2024 16:05:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Erik Schilling <erik.schilling@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20240129103541.rofgvhgkskcoavnv@vireshk-i7>
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com>
 <20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
 <87r0jjfw21.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0jjfw21.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On 18-12-23, 15:02, Cornelia Huck wrote:
> Other things that probably should be mandatory:
> 
> - A way for the driver to change the device status. Reading it would
>   probably be a strong SHOULD.
> - A way to implement config space. (For example, channel devices don't
>   have a config space or anything similar enough to repurpose, so I had
>   to invent a mechanism for ccw... maybe future transports will be in
>   the same boat.)

How about these changes now, before I post them again:

diff --git a/content.tex b/content.tex
index 0a62dce5f65f..2a86b1041747 100644
--- a/content.tex
+++ b/content.tex
@@ -631,8 +631,81 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
-Virtio can use various different buses, thus the standard is split
-into virtio general and bus-specific sections.
+Devices and drivers can use different transport methods to enable
+interaction, for example PCI, MMIO, or Channel I/O. The transport
+methods define various aspects of the communication between the device
+and the driver, like device discovery, exchanging capabilities,
+interrupt handling, data transfer, etc. For example, in a host/guest
+architecture, the host might expose a device to the guest on a PCI bus,
+and the guest will use a PCI-specific driver to interact with it.
+
+The standard is split into sections describing general virtio
+implementation and transport-specific sections.
+
+\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
+
+The transport MUST provide a mechanism for the driver to discover the
+device.
+
+The transport must provide a mechanism for the driver to identify the
+device type.
+
+The transport MUST provide a mechanism for communicating virtqueue
+configurations between the device and the driver.
+
+The transport MUST allow multiple virtqueues per device. The number of
+virtqueues for a pair of device-driver are governed by the individual
+device protocol.
+
+The transport MUST provide a mechanism that the device and the driver
+use to access memory for implementing virtqueues.
+
+The transport MUST provide a mechanism for the device to notify the
+driver and a mechanism for the driver to notify the device, for example
+regarding availability of a buffer on the virtqueue.
+
+The transport MAY provide a mechanism for the driver to initiate a
+reset of the virtqueues and device.
+
+The transport MUST provide a mechanism for the driver to read the
+device status. The transport SHOULD provide a mechanism for the driver to
+change the device status.
+
+The transport MUST provide a mechanism to implement config space between
+the device and the driver.
+
+\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
+
+Any data associated with a device-initiated transaction MUST remain
+accessible to the driver until the driver acknowledges the transaction
+to be complete.
+
+The device MUST NOT access the contents of a virtqueue before the
+driver notifies, in a transport defined way, the device that the
+virtqueue is ready to be accessed.
+
+The device MUST NOT access or modify buffers on a virtqueue after it has
+notified the driver about their availability.
+
+The device MUST reset the virtqueues if requested, in a transport
+defined way, by the driver.
+
+\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
+
+The driver MUST acknowledge device notifications, as mandated by the
+transport.
+
+The driver MUST NOT access virtqueue contents before the device notifies
+about the readiness of the same.
+
+The driver MUST NOT access buffers, after it has added them to the
+virtqueue and notified the device about their availability. The driver
+MAY access them after the device has processed them and notified the
+driver of their availability, in a transport defined way.
+
+The driver MAY ask the device to reset the virtqueues if, for example,
+the driver times out waiting for a notification from the device for a
+previously queued request.
 
 \input{transport-pci.tex}
 \input{transport-mmio.tex}

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

