Return-Path: <virtio-dev-return-14086-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D4C07CA9
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 08:13:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC50B163E4E
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 08:13:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55A92986882
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 08:13:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D9AF98666D; Thu, 30 Nov 2023 08:13:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F4FF986671
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 08:13:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701332016; x=1701936816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG5Q+TCbAkl1FEbOvEY0fT9oAGdK9DeMxicjiCd+I0Q=;
        b=wbUd2T/74NIwTwZWEnEESTyTpeH3ixae86tval0OBafMzukkw6u2AhgbfeMZ7CjPKB
         RlWGiylxy++P105eCUg4YHqpKiRNoVCqbTj58i22pRgbAorSL6i69hWpoFIZuGb3X8+G
         ovM9CfwnVzj2QnPYbwsWt/bc7Tlbf+PsevkKrCf4Ee/SKxM6qD2ts9TXHfbtRd32NM27
         R+1y9//XctGoDRUprXkZ/pIU97O7MXy5S0ZHwulVHVzNGkB6SG/KbU05KOQ4OECiUYVF
         1Xj5cLXqaV5xDgk2kP0vx/g93k5q+gyyXgpuWrHHFgJ/oGOnwVscGiyMVx2iFlry5V8u
         J9Fw==
X-Gm-Message-State: AOJu0YxVwIkz1IOTOy4yEAfMABVRlczeLBl2wwbuCb6KFg+l7luQnvbu
	VnnwDBy7CjncrSk2Ziz9Qm74DZb/O66JmbT1oLWU7aPHIiOvfMKm
X-Google-Smtp-Source: AGHT+IFa8I6c15SPUDs6HlTS2VWJv2XHIAjpK8g8dWwcpL2gfc/h7lZ7Y1rI+5JSSnGH7f2nZbPFhaHzVuIVuaS+peY=
X-Received: by 2002:a05:6512:2314:b0:50b:a823:8422 with SMTP id
 o20-20020a056512231400b0050ba8238422mr14044722lfu.47.1701332016382; Thu, 30
 Nov 2023 00:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20231113061950.122683-1-stevensd@chromium.org>
In-Reply-To: <20231113061950.122683-1-stevensd@chromium.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 30 Nov 2023 17:13:25 +0900
Message-ID: <CAD=HUj7O2HaJQUAmpOVm6P9nwdx8y4rnOTJD4wLKYkFZE5zTog@mail.gmail.com>
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/1] Define low power mode for devices

On Mon, Nov 13, 2023 at 3:20=E2=80=AFPM David Stevens <stevensd@chromium.or=
g> wrote:
>
> The virtio spec currently does not include the concept of device power
> management. The lack means that there is no good action drivers can take
> when they are requested to put the device into a low power state (e.g.
> when a guest is entering a system-wide low power state like S0ix/S3).
> Stateless devices can be handled - albeit inefficiently - by resetting
> and reinitialzing the device. However, stateful devices cannot support
> this situation. This patch defines a low power mode for devices that can
> be used in this situation.
>
> Low power mode is mostly defined at the transport layer, and all
> device-side power optimizations are optional. This avoids the need for
> invasive device-by-device definitions. It also pushes the requirement
> onto the device side, to simplify what driver side changes are
> necessary to just [1].
>
> I believe this patch may address the virtio-gpu issue which [2] is
> trying to address by avoiding the reset altogether when the guest enters
> S3.
>
> [1] https://lore.kernel.org/lkml/20231113055138.117392-1-stevensd@chromiu=
m.org/
> [2] https://lore.kernel.org/lkml/20230919114242.2283646-1-Jiqian.Chen@amd=
.com/
>
> v1 -> v2:
>  - Define virtio-pci support on top of PCI power management.
>  - Add more conformance requirements.

Friendly ping, and directly CC'ing reviewers.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

