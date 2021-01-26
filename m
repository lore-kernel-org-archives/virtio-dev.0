Return-Path: virtio-dev-return-7959-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94B3D98624D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Jan 2021 07:40:57 +0000 (UTC)
Date: Tue, 26 Jan 2021 08:40:41 +0100 (CET)
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
In-Reply-To: <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
Message-ID: <8dce1870-9ffe-949d-ee5a-f2564f88ac5@intel.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com> <20210124165408.1122868-8-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 7/9] ALSA: virtio: introduce jack support
Content-Type: text/plain; format=flowed; charset=US-ASCII
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On Sun, 24 Jan 2021, Anton Yakovlev wrote:

> Enumerate all available jacks and create ALSA controls.
>
> At the moment jacks have a simple implementation and can only be used
> to receive notifications about a plugged in/out device.
>
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> ---
> sound/virtio/Makefile      |   1 +
> sound/virtio/virtio_card.c |  18 +++
> sound/virtio/virtio_card.h |  12 ++
> sound/virtio/virtio_jack.c | 255 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 286 insertions(+)
> create mode 100644 sound/virtio/virtio_jack.c

[snip]

> diff --git a/sound/virtio/virtio_jack.c b/sound/virtio/virtio_jack.c
> new file mode 100644
> index 000000000000..83593c59f6bf
> --- /dev/null
> +++ b/sound/virtio/virtio_jack.c
> @@ -0,0 +1,255 @@

[snip]

> +/**
> + * virtsnd_jack_parse_cfg() - Parse the jack configuration.
> + * @snd: VirtIO sound device.
> + *
> + * This function is called during initial device initialization.
> + *
> + * Context: Any context that permits to sleep.
> + * Return: 0 on success, -errno on failure.
> + */
> +int virtsnd_jack_parse_cfg(struct virtio_snd *snd)
> +{
> +	struct virtio_device *vdev = snd->vdev;
> +	struct virtio_snd_jack_info *info;
> +	unsigned int i;
> +	int rc;
> +
> +	virtio_cread(vdev, struct virtio_snd_config, jacks, &snd->njacks);
> +	if (!snd->njacks)
> +		return 0;
> +
> +	snd->jacks = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*snd->jacks),
> +				  GFP_KERNEL);
> +	if (!snd->jacks)
> +		return -ENOMEM;
> +
> +	info = devm_kcalloc(&vdev->dev, snd->njacks, sizeof(*info), GFP_KERNEL);

just kcalloc()

> +	if (!info)
> +		return -ENOMEM;
> +
> +	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_JACK_INFO, 0, snd->njacks,
> +				    sizeof(*info), info);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < snd->njacks; ++i) {
> +		struct virtio_jack *jack = &snd->jacks[i];
> +		struct virtio_pcm *pcm;
> +
> +		jack->nid = le32_to_cpu(info[i].hdr.hda_fn_nid);
> +		jack->features = le32_to_cpu(info[i].features);
> +		jack->defconf = le32_to_cpu(info[i].hda_reg_defconf);
> +		jack->caps = le32_to_cpu(info[i].hda_reg_caps);
> +		jack->connected = info[i].connected;
> +
> +		pcm = virtsnd_pcm_find_or_create(snd, jack->nid);
> +		if (IS_ERR(pcm))
> +			return PTR_ERR(pcm);
> +	}
> +
> +	devm_kfree(&vdev->dev, info);
> +
> +	return 0;
> +}

Thanks
Guennadi

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

