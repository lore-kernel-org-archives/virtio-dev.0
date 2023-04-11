Return-Path: <virtio-dev-return-12131-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BA2C77B73
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:11:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C5DBC2A82E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:11:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF3419863A4
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:11:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B2D8F98636D; Tue, 11 Apr 2023 14:11:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A36F998636E
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 14:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YkyKC6ORM724l7TOlRnKsw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+54MM3N81uKS+P7N8YYQ94+Kcv0j9wz5fIvEDnpn6wY=;
        b=KylgEX49sbfh+tLfo+XjhK88IBdKKl276b1AQ7iOeeNr83ICZkI4zqy4qUfqaPGMmN
         MIioiEROfSIiMtWZOLRBMI71cxN299xNFkUyqslp/nBlU3/feQ1nAjw4e7F4/ljcZH1x
         VcJYMvNRrN6VRxVdimfc8rni6HdzxCrrSxllguantNjpGEXDlxYtZ1CL0GgZyGVUhSQt
         7I84J2E/WOwsAHFChRJxRArn3+SwIWDYx4WQRC+CsnpCBJESXNs8F56NUhdU8nX4Rm5D
         ZKCnX5+YRBRkZk5csv7P1kM7nFBMX7ggab4rNDm/WHehrvUcXi2YoKed42qH15NqDuY1
         Ufaw==
X-Gm-Message-State: AAQBX9e2ewxs20w4Bbdv4y7E8QAkCpNmhfuvJLyuBafGzJFFV9neQIQB
	JGUidpKpZWO/IZcHEJ5QmxGWvKwBagRCbwcjyp5B++1nGPTdSeelFSVS819vKLpplKq9dTuUBdi
	NOjwHhT2IM93e8qXblkLqVacw+ddY
X-Received: by 2002:a5d:4942:0:b0:2ef:ba57:ee2d with SMTP id r2-20020a5d4942000000b002efba57ee2dmr8208975wrs.51.1681222267902;
        Tue, 11 Apr 2023 07:11:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350bO9FXYbqiYy771jSZiEjBTnCYWQ08WyEt3/qnchYDTfxLwHbKBLDQrxwudlwd6mZ9ojkI3ZA==
X-Received: by 2002:a5d:4942:0:b0:2ef:ba57:ee2d with SMTP id r2-20020a5d4942000000b002efba57ee2dmr8208950wrs.51.1681222267567;
        Tue, 11 Apr 2023 07:11:07 -0700 (PDT)
Date: Tue, 11 Apr 2023 10:11:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230411101034-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
 <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEui1ouE8DcXKkWUavToUT+vEP-c640vtw3BJBOSz5YTkw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Tue, Apr 11, 2023 at 05:07:11PM +0800, Jason Wang wrote:
> > now, imagine someone building a new device. if existing drivers are not
> > a concern, it is possible to move capabilities all to extended space. is
> > that possible while keeping the bios working?
> 
> This is possible but I'm not sure it's worthwhile. What happens if the
> device puts all capabilities in the extended space but the bios can't
> scan there?

that's my question. why can't bios scan there?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

