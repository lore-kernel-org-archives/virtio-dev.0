Return-Path: <virtio-dev-return-14112-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A98C07E97
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 04:18:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C8EB12B07C
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 04:18:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D18C98658C
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 04:18:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74C7098644F; Tue,  5 Dec 2023 04:18:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60E45986458
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 04:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JJZuaDZyNxi1p2VqC3USaA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701749892; x=1702354692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7ljIY5PP2Bzhx16heL8WvwkVpNwM5kZAhu+t4uz6q8=;
        b=LGKI6wQcYaaWusK+HjYrv3+C9XNpGq+cniwqtQdiPA1H3tRUbKDfztValjLmn95B6q
         IOJu6zcOlK1vOW7FWeFonM+vZy38lFGz/OnX9zk/CmpZMCgKHWP7HS+PNQEGeRwx8Xi+
         Tj/jmj2MtVmvhT6+Nmq5aXj+E+WfHt4sWMXbyRmvQhgzDmnbgpARCB5y4FsarBR6iNu+
         xI4DvhxN3TMjio070mQ8LJTJd+PX92GB5kORCfFvErwnibA8wIxdHJFJRLMTpLW21TXb
         htyq+DkavcULPbURZZ0TQlXGyAFIIa8SpsEdwaDUrntun9ZI9B9Yc2QrwoM832Lj69t1
         ummQ==
X-Gm-Message-State: AOJu0Ywv/Z8rLq8gyq04jczfqYRt69Ec/DWD/BmxCZy38VWseXkdOrkM
	R3dP2CbYU7OyFl34jsIvBYzR3qfXNA++1TCXGaybhZRzOqVJjwSw7t9yAUtE5b5eNN4bWnoTBbZ
	zC9YHl+9qGtgxjDVp9pwXmMD/MM9RiSPipTyL0RWnUw3g
X-Received: by 2002:ac2:5610:0:b0:50b:fb38:f7bf with SMTP id v16-20020ac25610000000b0050bfb38f7bfmr849607lfd.69.1701749892719;
        Mon, 04 Dec 2023 20:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrWr/mEvS853L1k68Rk7MRPiuZj0hyFJFUfWF1odN2Ec2R08Q/psFA8bw1hzP4EgcqVAnoluA9g2vGsP6pCRM=
X-Received: by 2002:ac2:5610:0:b0:50b:fb38:f7bf with SMTP id
 v16-20020ac25610000000b0050bfb38f7bfmr849602lfd.69.1701749892335; Mon, 04 Dec
 2023 20:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20231204094123.856214-1-stevensd@chromium.org> <20231204094123.856214-2-stevensd@chromium.org>
In-Reply-To: <20231204094123.856214-2-stevensd@chromium.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Dec 2023 12:18:01 +0800
Message-ID: <CACGkMEuHLs=+8_RHVa9eTXfHLqo_Ra6hSrnT9k8DAG_0yz0pvQ@mail.gmail.com>
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] Define a low power mode for devices

On Mon, Dec 4, 2023 at 5:41=E2=80=AFPM David Stevens <stevensd@chromium.org=
> wrote:
>
> Define a low power mode for virtio devices where the devices are
> expected to maintain their state. This gives drivers an option for power
> management besides simply resetting their device. In the virtualization
> use case, this allows the guest to be suspended even with stateful
> virtio devices like gpu and fs.
>
> Low power mode is primarily defined at the transport layer. The only
> part that depends on device-type specific details is whether a given
> virtqueue is device driven or driver driven.
>
> This change only defines the transport-specific implementation for
> Virtio over PCI.

A dumb question, if this is only for PCI, can the device just
implement no_soft_reset via PMC?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

