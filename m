Return-Path: virtio-dev-return-8044-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4A78986223
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 22:19:35 +0000 (UTC)
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
 <20210225135951-mutt-send-email-mst@kernel.org>
 <s5hblc7opok.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <0a9f6dea-ed75-16eb-9fc2-84148fa820be@opensynergy.com>
Date: Thu, 25 Feb 2021 23:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <s5hblc7opok.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 25.02.2021 21:30, Takashi Iwai wrote:> On Thu, 25 Feb 2021 20:02:50 
+0100,
> Michael S. Tsirkin wrote:
>>
>> On Thu, Feb 25, 2021 at 01:51:16PM +0100, Takashi Iwai wrote:
>>> On Thu, 25 Feb 2021 13:14:37 +0100,
>>> Anton Yakovlev wrote:


[snip]


>> Takashi given I was in my tree for a while and I planned to merge
>> it this merge window.
> 
> Hmm, that's too quick, I'm afraid.  I see still a few rough edges in
> the code.  e.g. the reset work should be canceled at the driver
> removal, but it's missing right now.  And that'll become tricky
> because the reset work itself unbinds the device, hence it'll get
> stuck if calling cancel_work_sync() at remove callback.

Yes, you made a good point here! In this case, we need some external
mutex for synchronization. This is just a rough idea, but maybe
something like this might work:

struct reset_work {
     struct mutex mutex;
     struct work_struct work;
     struct virtio_snd *snd;
     bool resetting;
};

static struct reset_work reset_works[SNDRV_CARDS];

init()
     // init mutexes and workers


virtsnd_probe()
     snd_card_new(snd->card)
     reset_works[snd->card->number].snd = snd;


virtsnd_remove()
     mutex_lock(reset_works[snd->card->number].mutex)
     reset_works[snd->card->number].snd = NULL;
     resetting = reset_works[snd->card->number].resetting;
     mutex_unlock(reset_works[snd->card->number].mutex)

     if (!resetting)
         // cancel worker reset_works[snd->card->number].work
     // remove device


virtsnd_reset_fn(work)
     mutex_lock(work->mutex)
     if (!work->snd)
         // do nothing and take an exit path
     work->resetting = true;
     mutex_unlock(work->mutex)

     device_reprobe()

     work->resetting = false;


interrupt_handler()
     schedule_work(reset_works[snd->card->number].work);


What do you think?


-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

