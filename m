Return-Path: virtio-dev-return-6655-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F003985EE3
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Jan 2020 10:12:58 +0000 (UTC)
Date: Tue, 14 Jan 2020 11:12:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200114101251.3qdo7w4zfsablo7t@sirius.home.kraxel.org>
References: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20200109140743.303046-1-Anton.Yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v5] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 09, 2020 at 03:07:43PM +0100, Anton Yakovlev wrote:
> This patch proposes virtio specification for a new virtio sound device,
> that may be useful in case when having audio is required but a device
> passthrough or emulation is not an option.

Looks good to me.  Where do we stand in terms of device/driver
implementations?  Trying to actually implement things sometimes
finds problems in the specification ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

