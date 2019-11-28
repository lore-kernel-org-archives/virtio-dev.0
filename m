Return-Path: virtio-dev-return-6421-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2EB34985ECB
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Nov 2019 11:42:09 +0000 (UTC)
Date: Thu, 28 Nov 2019 12:42:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191128114202.eyhjrnuragsznmwc@sirius.home.kraxel.org>
References: <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122123521.GB6849@sirena.org.uk>
 <4db86201-ea0b-80e0-5714-ffa598bee34f@opensynergy.com>
 <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
MIME-Version: 1.0
In-Reply-To: <D68AC0D0-851B-4F87-BE0E-F49527B83E24@redhat.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Christophe de Dinechin <cdupontd@redhat.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> Is the intent that any virtio device has to support all the same formats?

No.

> So it looks to me like all the formats should be part of the spec, and so=
me
> device capabilities should indicate which ones the device accepts.

There is a per-stream bitmask in device config indicating which formats
are supported.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

