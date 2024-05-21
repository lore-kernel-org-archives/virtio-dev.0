Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4E7641B
	for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292862; cv=none; b=fQ8PbWkKM2BKeUmkc19ULCM6egnz5YbBiSCrqdeJwMXxlQC6ffN94qWLQUAMG1hQitrZ8e08HvOgBWXLTsE87EM9Y8EfgdeTMq9NvLsyMy0xXlGVutrEbzLmGwWg7MedMdnUGG06HaUGTvot5Ur8n04TDo0C9+ZLfg55oPVWAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292862; c=relaxed/simple;
	bh=zyRos6+nm+B//FsYx6qlYXSeQ1QrYKkewvsd1p8UOkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlNJENJDjtgJh4YQkz0A80F4GF8hat0EzC7GYa9Ddr7D1yDJuT3qh6TxfBnm9dDcepbqvAnVGY5D0AWWfJ/c46bWGml9dW4Cf/IXXVPTpppy7J80x8r9+1ilIl5lyOTcHJd1qt/QqC25XY7Sqa4Os4zT0y9Tv54nZTVtHauR1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ3C2KD+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ3C2KD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716292859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+W8fQmzVJmEskABK6vjGK79R3gRVRNgvQqYUqws2JTY=;
	b=MQ3C2KD+BZyKLT8bSdMCLBvO9a8IQ3s7KeZDGwC+JLJDggORhLRBO9SeO2CigH9J6DRFEA
	uqSoZXeoM4xGKpIPDbq6IWjy81XanzWd5OnZ0NkzTzSkYM6Q9ISeOTQLOI5nNl6IBwgW/4
	llU/zCqyFkKiVOpmrs9WvE3DdCumUOQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-huEru5smOaqraMOPc6ZZNg-1; Tue, 21 May 2024 08:00:56 -0400
X-MC-Unique: huEru5smOaqraMOPc6ZZNg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3501dab32fcso1286274f8f.0
        for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 05:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292855; x=1716897655;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+W8fQmzVJmEskABK6vjGK79R3gRVRNgvQqYUqws2JTY=;
        b=TbpzBpMTAdaF4rbxGro0g+DZfguRM+juE7xfUSQSXFwNWlajCHJipoLnmHOQYr+NbT
         dXnK6AoZgQxzgPV/7q6PxXI6upYjR6WAyz/bYGa8n+8InrvNkQ43yF4nhLsH162yMJGZ
         ZqefDwsxW2/ZA5I2nzkkQnovH/zlps2h+DUqPAggx44Jlpwnn//ELNDYXMlPs8I+Uc30
         SLzudKI+r15aFD06vOU68jyJI9ba7BfuDOpHYRcQ3xWqCnRRamHqcU8n6JRGYEW7noC0
         BXJdGcaLvXdcO7e8nVzWlwNSyECBGmuDg9f0inFR8xcdrtTWsNxR7GTABemzaHJmXsKt
         VHwQ==
X-Gm-Message-State: AOJu0YxcgAxiiEtTQua1/LOSmmgvtGj5w7CbcRD1ckzmYV+IdOk0WJjd
	M7M6jsa3zfX03N/dGtW3daVooDWKffkpZP9Hft7TY14myAVLnHkx6k1xujQhDfA015iIYOcMqIA
	YP5URq7wwFRf50gEtBfKb9NiVu9Hguw/EdE/6WWJf5d4vKPwuUMvdtJr0eEU=
X-Received: by 2002:adf:e9c9:0:b0:34f:42d5:1897 with SMTP id ffacd0b85a97d-3504a968bdcmr25562219f8f.3.1716292855450;
        Tue, 21 May 2024 05:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUXzAxSq9gDJBaU7WxjfeEZHRrvnoGo5u6SqdSpexNZMdI/KCScuMYnkI7su5REvMxy0pggw==
X-Received: by 2002:adf:e9c9:0:b0:34f:42d5:1897 with SMTP id ffacd0b85a97d-3504a968bdcmr25562192f8f.3.1716292854974;
        Tue, 21 May 2024 05:00:54 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc8esm31616210f8f.15.2024.05.21.05.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:00:54 -0700 (PDT)
Message-ID: <6bcc161ed07f7a1abb0106f6a622ccea1fcf815c.camel@redhat.com>
Subject: Re: [PATCH v3] virtio-net: define UDP tunnel offload feature
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, maxime.coquelin@redhat.com, Eelco Chaudron
	 <echaudro@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 14:00:53 +0200
In-Reply-To: <20240521034028-mutt-send-email-mst@kernel.org>
References: <f0bf2db203f8061a3ecb50b7a48cf26d8f3c7f68.1716193086.git.pabeni@redhat.com>
	 <20240520225254-mutt-send-email-mst@kernel.org>
	 <2dd731c45ee016fcca416d18d21882947bbf9f9d.camel@redhat.com>
	 <20240521034028-mutt-send-email-mst@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-05-21 at 03:41 -0400, Michael S. Tsirkin wrote:
> On Tue, May 21, 2024 at 09:25:51AM +0200, Paolo Abeni wrote:
> > Hi,
> > On Mon, 2024-05-20 at 22:55 -0400, Michael S. Tsirkin wrote:
> > > when you subscribed to virtio-dev you should have received this:
> > >=20
> > > When to use this list:
> > > - questions and change proposals for Virtio drivers and devices
> > >   implementing the specification.
> > >=20
> > > When not to use this list:
> > > - questions and change proposals for the Virtio specification,
> > >   including the specification of basic functionality, transports and
> > >   devices (please use the virtio-comment mailing list
> > >   [mailto:virtio-comment@lists.linux.dev] for this).
> > >=20
> > >=20
> > > Did you receive this?=C2=A0
> >=20
> > Yes, I received it.
> >=20
> > > If yes was this somehow unclear?=C2=A0 If no why are you sending a Vi=
rtio=C2=A0
> > > specification change proposal to virtio-dev?
> >=20
> > Given your reply I guess my interpretation was wrong.
>=20
> What was your interpretation?

I really misread the first sentence as anything concerning virtio
drivers or their specification should land here.

I guess I confused myself because in the past I already misused the old
virtio-dev oasis ML with spec related mails the few times I used it.

> > Should I reply to
> > Jason and Stefano feedback here, or move the discussion entirely on
> > virtio-comment?=20
> >=20
> > Thanks,
> >=20
> > Paolo
>=20
> Repost to virtio-comment I think, restart the discussion.
>=20
I will do,

thanks!

Paolo

