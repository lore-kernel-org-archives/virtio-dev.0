Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFE182C5
	for <virtio-dev@lists.linux.dev>; Tue,  8 Oct 2024 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353716; cv=none; b=bcNXp3hmvp6Z+4X4Lbfv/zJZn/ZOin1D4C2JjyOX01+uqbOjvlsb+NiTxGBpQEZk50KFaPX3TJCVCbgWEpOkolAVOGwnRqLlFtSqSml/G1qu83MErF7tufudTGK+s8jxWJQde0c1wIu7sY2ofxVkoXxSMe6+sVAPgWXBjgvv0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353716; c=relaxed/simple;
	bh=vsZQK+8MtGo/bpXC5EnzfEllcfJ1/Dm6odiVEfnznGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkF8CWy3/L07Xmm/rQ6DF02gm4fKj487zbdaFV45Lu7Z8fQ2nFN7ECif+TxRIPFQH4Th9XuEp/8YkQntDfmf/uJUsSCHvODbtx7AKTh+FD0+BKHW/+p4XxuRm/Q7bF3rRUBq6xnOdtYFhQtePYiwyaO2eD7tp/PPNKA4XyEcpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iizCd7sE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iizCd7sE"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a995a0fc401so15789066b.2
        for <virtio-dev@lists.linux.dev>; Mon, 07 Oct 2024 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728353713; x=1728958513; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RekqTme8wdJ4AVUTH9HdSV0fpbAq2HmemVWIdGYXdHc=;
        b=iizCd7sEHa78paRM88h2CKay/UuCPfaFXhcRrzOeYpQVJL+B+VYDngbxOTSycBzOxm
         57JjonOPteMFAHdCWQquM44iq/FZiQbf4wtI607YXyw89H0tIwjgnybgADh68cdQxgHD
         y3uEgD/uR4SHsq8lDknCR045rtiig971P4CPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728353713; x=1728958513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RekqTme8wdJ4AVUTH9HdSV0fpbAq2HmemVWIdGYXdHc=;
        b=D2WS3F/CG68iSMFY2RMRVr3uODCD8iM04M7mgB/hL2Y1OWKMwY5q7riAEe8gwC+RMn
         Y77cUXZQZl/HdPX+YFIskXySkp4dooJ9hQrPgaMwMewbilkk6aIUysE9gE8bIq3oeUoT
         KocyyxQLe76CS64+/grfkNIIL8KIs1ssI7VTIQeHZQdd5RbB9dzElPrxmrVsVFf3vbpl
         XQwHkF1t6a9Nxoo5bPPoW7ld6DRSx3sssyp/jvfTvuAf5UiLkvg0YVyH6hlujz8ZEYZs
         LoV7tdvucxUm4OTaCr8rga6Evq6oEvuuEQYGfvuZPbPeIjJF1P0Hf+O/1Vns0ayiiB0y
         oLyw==
X-Forwarded-Encrypted: i=1; AJvYcCXhEe9ysFfaBy97qZQF11i385WbFCshUOHIA1Yo2wmnf54wegt1N8D/yhje6OG7bM1Kp25XzQQLZeOX@lists.linux.dev
X-Gm-Message-State: AOJu0YzGKznDPnIMfAZe3WvZ9xdNQK5qJDBEOUshttlQNiIMTz9Kuf7j
	KgTDaYOUE5+ZtI+WjMpAAc39oR/n8lOLLBs0qz1IWjexN8HP/xwJzgWs80nBg7Pcy0Zf5+cJpx8
	=
X-Google-Smtp-Source: AGHT+IFMhV+NuglQNE/oNL+SRDRe1dqOL0GPTAADqdJuhxQnP1vaMt7FjUddeMNPNkzCxVf1af5I6g==
X-Received: by 2002:a17:906:29ca:b0:a99:408c:6a0f with SMTP id a640c23a62f3a-a99408c6b71mr351182266b.5.1728353712824;
        Mon, 07 Oct 2024 19:15:12 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a996ebc30d6sm37403566b.101.2024.10.07.19.15.10
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:15:11 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9950d27234so254749766b.1
        for <virtio-dev@lists.linux.dev>; Mon, 07 Oct 2024 19:15:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRm1f6+BPUYSb1FGlDErV4FOlhspoymDVw7/RYDYf/9i5wRYl1hRYLPESOrFhH1rPAFzIIl/ck4F6M@lists.linux.dev
X-Received: by 2002:a17:907:7fa6:b0:a99:61d1:34a2 with SMTP id
 a640c23a62f3a-a9961d14dbcmr257684466b.37.1728353710341; Mon, 07 Oct 2024
 19:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
In-Reply-To: <20241006165609.34953-1-mgurtovoy@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Oct 2024 19:14:44 -0700
X-Gmail-Original-Message-ID: <CABVzXAkVOV-nYno+oi_KJhaD1cCZMNo6FtoPdHPfUauvnaAw7w@mail.gmail.com>
Message-ID: <CABVzXAkVOV-nYno+oi_KJhaD1cCZMNo6FtoPdHPfUauvnaAw7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 9:56=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:
>
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
>
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
>
> Add description for this field to provide clarity on its constraints.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>
> changes from V1:
>  - Addressed Stefan's and Daniel's comments:
>        1. use SHOULD instead of MUST
>        2. Add a note that devices may return IOERR upon misaligned IO
>  - Add a note that devices may return IOERR if IO size is not following
>    the block size granularity.
> ---
>  device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 2712ada..77eed80 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -135,6 +135,9 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / Block Device /
>  present. The availability of the others all depend on various feature
>  bits as indicated above.
>
> +The field \field{blk_size} exists only if VIRTIO_BLK_F_BLK_SIZE is offer=
ed by the device.
> +This field reports the block size of the device, expressed in bytes.
> +
>  The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This=
 field specifies
>  the number of queues.
>
> @@ -282,6 +285,13 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
> +Drivers SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered=
 by the
> +device. When negotiated, drivers SHOULD interpret the \field{blk_size} a=
s the
> +logical block size.
> +
> +If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then =
drivers
> +MAY assume that the logical block size is 512 bytes.
> +
>  Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
>  sending VIRTIO_BLK_T_FLUSH commands.
>
> @@ -319,6 +329,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
>
> +Devices SHOULD always offer VIRTIO_BLK_F_BLK_SIZE feature. When this fea=
ture is
> +offered, devices MUST initialize \field{blk_size} to a power of two grea=
ter
> +than or equal to 512.
> +
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
>  if they offer VIRTIO_BLK_F_CONFIG_WCE.
>
> @@ -879,6 +893,14 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BL=
K_T_IN
>  and VIRTIO_BLK_T_OUT requests.
>
> +The length of \field{data} SHOULD be a multiple of \field{blk_size} for =
VIRTIO_BLK_T_IN
> +and VIRTIO_BLK_T_OUT requests, when the VIRTIO_BLK_F_BLK_SIZE feature ha=
s been
> +offered by the device.
> +
> +The value of \field{sector} (multiplied by 512) SHOULD be aligned with
> +\field{blk_size} for VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests, when=
 the
> +VIRTIO_BLK_F_BLK_SIZE feature has been offered by the device.

Instead of "aligned", perhaps "SHOULD be a multiple of
\field{blk_size}" to be consistent with existing spec wording like
"MUST be a multiple of 512 bytes".

>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
>  VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
> @@ -966,6 +988,18 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST =
NOT
>  write any data.
>
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the requested
> +\field{sector} (multiplied by 512) is not aligned with the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offere=
d by
> +the device.
> +
> +A device MAY set the \field{status} to VIRTIO_BLK_S_IOERR for
> +VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT requests if the length of the
> +requested \field{data} is not an integer multiple of the device's
> +\field{blk_size}, when the VIRTIO_BLK_F_BLK_SIZE feature has been offere=
d by
> +the device.
> +
>  The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
>  discard, secure erase and write zeroes commands if any unknown flag is s=
et.
>  Furthermore, the device MUST set the \field{status} byte to
> --
> 2.18.1
>

This all looks reasonable to me, so Reviewed-by: Daniel Verkamp
<dverkamp@chromium.org> if you'd like.

One other thought: if a device truly can't handle misaligned I/O
requests, it could also choose to fail at feature negotiation time if
it offers VIRTIO_BLK_F_BLK_SIZE and the driver does not accept it. I
am not sure this is in the spirit of the existing general section
"Device Requirements: Feature Bits" (it says "any valid subset of
features", but maybe your device would consider not negotiating
VIRTIO_BLK_F_BLK_SIZE to be an invalid subset of features?)

Thanks,
-- Daniel
