Return-Path: <virtio-dev-return-14301-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC01C48260
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 355E342A79
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F0849864F3
	for <virtio-dev@archiver.kernel.org>; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1404D986436; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06C1D98644C
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Feb 2024 09:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: p2sUUvbqN06MdJqvkPkU6w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815264; x=1708420064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=varjZjBxBFqiVHNuiFV3KRQmhIyNRarw3ydRqMvY0A0=;
        b=kJ7/iwahc0k1eRAT1ywloZUwTz5chIealn2BhvtePx6xnNACNn2EKTpoY5AemF6TPt
         Sl9b3vla6CmKxwg/F3v/i6pBMcHaiGPfRvKwxAfJdrNyNjy+aVCqxD0gw8GoFQBDAyRF
         NPBD4J4hwdvsx1bNp8GHIhTkIAUiA64P/MOMGI/nnqhBkjGaaI97WzajbKj01VO+7N4L
         4w6ODUWyimCsW1qdOMqEkTe33UWhgbD6H59qMJXFn7wNAIARkpqEILDbNm/HabCPdbni
         9xfq7D8AHuinUHzuJ8VY1XNMwGf/VFspN2fgRn7KS+vbQLvysJqd4w6nk0FIAyb4CCPu
         zZZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHN/zFaOuf47c6Gpwgkie/m/jZalWdxDbirzCX4SiVdLKX1de5EWIih9IWAVVfspmKQR/ipGlFRNSwsJ7mArONqP+/XY12H0zCKsZOtOY+
X-Gm-Message-State: AOJu0Yz0QDhlMU0MityGQ6+gMokPutoxoMqsVn1Ubar3gLmI2mmog+hT
	jia7/u3zXOlZ7/nZhF8z2JsO2MsZfw91n/EsTPm9I1ad0r511E4oIitVXeOqxLAO5tVanGMWyQO
	ZyisazO+8VxFWx25ACtwTBSzLFVB03vb8vXfg51cMi1Jr+vdBO7J3ZmbfwmVTmbJzaQ==
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568430ejq.63.1707815264364;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/xK+Aor/xzZTH8ME0aRC9uoXcmBdxOZhpQPgo5eNwxfgfoP2CKnpOj1sxDSyFQjvppURq7w==
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568406ejq.63.1707815264001;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxvJmPUdeHNhcIV56A+eFY+jIFHXqBuVrnXrw1vzKVCoicf5DD7YBH2FP/A75tPGUjqR+Bc7XZxFsYsZeq0HBoO9Z0tCIO7k3EOLK7Rl3bi2ETScxzuLVtCBJnX3e+hJlelVaztSoUjWIhiujpMwgrFJYAVTVbhAuD9h4nK8+Qa9yOlIrhcgi4L6nIlbe4ExdIO/Glr2sj0sGQ0AdFrmnLWj1QJTyzoyL39rGoAVKf6P5LmQxe4NxPIURm9wuOYcJx6pnp/UaAWrUVKxMf4He4d7A5BK1KcuvGNcHh16VSgmMvr1WDs2UlPvaBp6qNb03Ks8prSMV4bnZE6DRU+xOIr0Jyu31lfSci5aDKPE5sB258A8v+eetmK06xPCqZFYiUwkTWjnhftymBZcIEPA==
Date: Tue, 13 Feb 2024 04:07:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, jasowang@redhat.com,
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Message-ID: <20240213040658-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <875xyska8v.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <875xyska8v.wl-tiwai@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.

On Tue, Feb 13, 2024 at 10:02:24AM +0100, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 09:51:30 +0100,
> Aiswarya Cyriac wrote:
> > 
> > Fix the following warning when building virtio_snd driver.
> > 
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> > 
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> Thanks, applied.
> 
> 
> Takashi

Why did you apply it directly? The patch isn't great IMHO.
Why not give people a couple of days to review?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

