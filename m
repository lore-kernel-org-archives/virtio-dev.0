Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC113FFD;
	Mon, 31 Mar 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421968; cv=none; b=JKi5B8FDyPBscNHMDj3lrQ3GcxecBoOf8mt42yTOkz/6jNauDUELe43CF05vDMGHLlVj8VvVnbrlQC0H6wZqEjHbyowVorbWqBRXMiAXvNHicBlIGEAdRF8DyEfLnTmf7H90Mpschlb+au2OQgIdB+Bub4Q0SUyJPX603ZKCp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421968; c=relaxed/simple;
	bh=s/G950E4iUD7P22iYcY1O+KKVXQiUvh2OUJBF7gOlhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxNCEZ0ywxMIfG+vNfcVSQIJjOx/ojoYhLfc32tsI4t9AefUuFK16m70v8a8U6p/5NQbCbBvhFhSvOfnedeqhujBrFbQpq99wHG796F0jgFjwgWbSowcac1nOUuWC9MgTaRrT5HN4xAYkSgUDOB1aEDHcXC9xdWQEoR0czNZsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAOncKQD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAOncKQD"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso7228682a12.0;
        Mon, 31 Mar 2025 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743421965; x=1744026765; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/G950E4iUD7P22iYcY1O+KKVXQiUvh2OUJBF7gOlhc=;
        b=OAOncKQDuXAsNB0V25TcVMIYC/A87n3hlDqyOq041kQMJqSK14DAc+fUzT8FRpoYxK
         iAfBArNwiJJ9nT5QLbpgvEAY6DJVNeCZUvDUIFTLogZQ0vSmNrkUsI3EIKsh9e/j9Fj1
         37YGfwQvOib14vG/G1Ne0ZfZhU7z5XUXppRZzTlZ7YQ8JrPpjMDTORxJhiAkuqzPudCG
         nHzjSJQsQuQ1oNPC1yXSF8JPITDWfrInCDLNCofyRHvuegHidvPo+TEQTyea73HeN9FU
         XK+P398oQmypRuGypLRT4PpYGINYn72pI0DDCqYoG+0aWrimpn8sQrl6B8ipFirLUvPp
         1pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421965; x=1744026765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/G950E4iUD7P22iYcY1O+KKVXQiUvh2OUJBF7gOlhc=;
        b=edfhxvA5H5M+1CHmZ4xYyrrDj3w1cp+jh83V/VMKnKUx7Hnitavv5QbCXVoeHFvQ4w
         F1K9YWEzgMS/d9eYUtV1tciKDoFTw3CFdIC9P0yVGZXjUanJEJUvQG+8QX3wqSbj8Bqe
         Wi132zo8Ne9D8sz2SDO8OtdFoK9b9h10lSDNp2CS9pKbjnLMJlD/9MiRcdRMgMe7CuUo
         0TdQ1AXR9huIukEI89le1r2DKgSqgNZ8aHQnb/5Q4xHJ2No+m5lZ7vtKqlMStKUGfj9e
         HLfYxk/vOKGyxYLfgA+z9Ji7zNzYQ8vhmCJ7G8dtVNzBXMBmkIoQWvc4N39AFVdRtHbZ
         KqXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTfcdC/VQePd3JKSEsdYk+HO+iidtGFY87y0uI03wDDOonreUdvgweAIGbr2yFvc1f6KmzuA8uhygs0A==@lists.linux.dev, AJvYcCVuabVVeRMNhrSAu7DNs6qdgc+7Nzf7v3NVn/KqnG/YZDWDRkth3RH9j3HzRc4wxiHiSzAF83Rr8kumnpRcTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl4WwAMyT2LUUVYYaU/vtZs1xPPyzMoAEadIekSthgT0TaHfMX
	SmZiGkiPL9oJGI47IzzipY88wrJg0mQw8V7HTf0080U1ijzdlCDl83psBfC4hBa0eKnuAcdzz5b
	4pd6++eAA8w7LpRqxFBdNHSVcIms=
X-Gm-Gg: ASbGncuPiyrDQ3c35WQs2AjuGO38pD0Bv2w2vgGjCvsSvlP7yufucsWbr4LM1kDg3Be
	9mC3ulJ60utCDDHGXWzUJ5IodstLyNpBM1+gZ0chABw+OfzfpsFAqfS1rMCsIof12oW+qdjg3+P
	LAJTku0axxIZXkSI9CvTtOzZHW
X-Google-Smtp-Source: AGHT+IHOrbPkbxgomn6Y+2zZLrB8tIiuu6p3PN58MiFeCvs+JPDdFCqU+2M7cjlk2IA/yHfECxpphkuq7EWXpx4ezvM=
X-Received: by 2002:a05:6402:4408:b0:5de:cbed:c955 with SMTP id
 4fb4d7f45d1cf-5edfd13cf32mr6865080a12.17.1743421965108; Mon, 31 Mar 2025
 04:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org>
In-Reply-To: <87semtpjrt.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 31 Mar 2025 07:52:33 -0400
X-Gm-Features: AQ5f1JoNUr2f9qRRayGY4AUInfDfArDciuLHO5VI_yHaTZ_LFyrfTuqkkH5rixQ
Message-ID: <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
Subject: Re: Central repo for VirtIO conformance tests?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Rust VMM <rust-vmm@lists.opendev.org>, QEMU Devel <qemu-devel@nongnu.org>, 
	virtio-comment@lists.linux.dev, VirtIO Dev List <virtio-dev@lists.linux.dev>, 
	Bill Mills <bill.mills@linaro.org>, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Matias Vara Larsen <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> So what do people think? Where would be a good place for common test
> repository to live?

Maintaining the tests alongside the VIRTIO spec seems like a good fit
to me. Here is information on how to create a GitHub repo under the
OASIS VIRTIO Technical Committee:
https://www.oasis-open.org/open-repositories/

I don't see a reason to maintain the tests under QEMU or rust-vmm
unless they provide some unique project infrastructure that an
independent project would lack or need to reinvent.

If it is not possible to host the tests under OASIS then they could be
hosted independently (as a separate organization on Codeberg, GitLab,
GitHub, etc) and not on any contributor company's infrastructure to
make them more sustainable and neutral for the long term.

Stefan
