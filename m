Return-Path: virtio-dev-return-7969-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 898A09865DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  1 Feb 2021 23:20:02 +0000 (UTC)
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
 <20210124165408.1122868-5-anton.yakovlev@opensynergy.com>
 <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <4eb2f618-1b8d-b339-8f85-ff061a1f563e@opensynergy.com>
Date: Tue, 2 Feb 2021 00:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <6f93189c-7cfc-25c7-6b2c-ad8e21bf42c@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/9] ALSA: virtio: build PCM devices
 and substream hardware descriptors
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 25.01.2021 16:44, Guennadi Liakhovetski wrote:
 > On Sun, 24 Jan 2021, Anton Yakovlev wrote:
 >

...[snip]...

 >>
 >> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
 >> index 955eadc2d858..39fe13b43dd1 100644
 >> --- a/sound/virtio/virtio_card.c
 >> +++ b/sound/virtio/virtio_card.c
 >> @@ -92,6 +92,17 @@ static void virtsnd_event_notify_cb(struct
 >> virtqueue *vqueue)
 >>                       if (!event)
 >>                               break;
 >>
 >> +                     switch (le32_to_cpu(event->hdr.code)) {
 >> +                     case VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED:
 >> +                     case VIRTIO_SND_EVT_PCM_XRUN: {
 >
 > In the previous patch you had a switch-case statement complying to the
 > common kernel coding style. It isn't specified in coding-style.rst, but
 > these superfluous braces really don't seem to be good for anything - in
 > this and multiple other switch-case statements in the series.

I will fix this. Thanks!


...[snip]...


 >> @@ -359,6 +384,8 @@ static int virtsnd_probe(struct virtio_device *vdev)
 >> static void virtsnd_remove(struct virtio_device *vdev)
 >> {
 >>       struct virtio_snd *snd = vdev->priv;
 >> +     struct virtio_pcm *pcm;
 >> +     struct virtio_pcm *pcm_next;
 >>
 >>       if (!snd)
 >>               return;
 >> @@ -376,6 +403,24 @@ static void virtsnd_remove(struct virtio_device
 >> *vdev)
 >>       vdev->config->reset(vdev);
 >>       vdev->config->del_vqs(vdev);
 >>
 >> +     list_for_each_entry_safe(pcm, pcm_next, &snd->pcm_list, list) {
 >> +             unsigned int i;
 >> +
 >> +             list_del(&pcm->list);
 >> +
 >> +             for (i = 0; i < ARRAY_SIZE(pcm->streams); ++i) {
 >> +                     struct virtio_pcm_stream *stream =
 >> &pcm->streams[i];
 >> +
 >> +                     if (stream->substreams)
 >> +                             devm_kfree(&vdev->dev, 
stream->substreams);
 >> +             }
 >> +
 >> +             devm_kfree(&vdev->dev, pcm);
 >
 > Please double-check both devm_kfree() calls above. Probably they aren't
 > needed in the .remove() method.

Then I will redo these parts, and the parts that you noticed in the rest
of the comments to this file.


...[snip]...


 >
 > Thanks
 > Guennadi
 >
 > ---------------------------------------------------------------------
 > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
 > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
 >
 >
-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

www.opensynergy.com


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

