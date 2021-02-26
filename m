Return-Path: virtio-dev-return-8049-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E921A9862C1
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Feb 2021 20:16:46 +0000 (UTC)
References: <20210222153444.348390-1-anton.yakovlev@opensynergy.com>
 <20210222153444.348390-7-anton.yakovlev@opensynergy.com>
 <s5h35xkquvj.wl-tiwai@suse.de>
 <d9b6e8fa-7356-1cbf-029b-6f7c8bad4994@opensynergy.com>
 <s5hlfbcpayj.wl-tiwai@suse.de>
 <20210225135951-mutt-send-email-mst@kernel.org>
 <s5hblc7opok.wl-tiwai@suse.de>
 <0a9f6dea-ed75-16eb-9fc2-84148fa820be@opensynergy.com>
 <s5ha6rqnc0m.wl-tiwai@suse.de>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <8243d984-0482-b9b5-e779-9f3f723d48ed@opensynergy.com>
Date: Fri, 26 Feb 2021 21:16:41 +0100
MIME-Version: 1.0
In-Reply-To: <s5ha6rqnc0m.wl-tiwai@suse.de>
Subject: [virtio-dev] Re: [PATCH v5 6/9] ALSA: virtio: PCM substream operators
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 26.02.2021 15:23, Takashi Iwai wrote:
> On Thu, 25 Feb 2021 23:19:31 +0100,
> Anton Yakovlev wrote:
>>
>> On 25.02.2021 21:30, Takashi Iwai wrote:> On Thu, 25 Feb 2021 20:02:50
>> +0100,
>>> Michael S. Tsirkin wrote:
>>>>
>>>> On Thu, Feb 25, 2021 at 01:51:16PM +0100, Takashi Iwai wrote:
>>>>> On Thu, 25 Feb 2021 13:14:37 +0100,
>>>>> Anton Yakovlev wrote:
>>
>>
>> [snip]
>>
>>
>>>> Takashi given I was in my tree for a while and I planned to merge
>>>> it this merge window.
>>>
>>> Hmm, that's too quick, I'm afraid.  I see still a few rough edges in
>>> the code.  e.g. the reset work should be canceled at the driver
>>> removal, but it's missing right now.  And that'll become tricky
>>> because the reset work itself unbinds the device, hence it'll get
>>> stuck if calling cancel_work_sync() at remove callback.
>>
>> Yes, you made a good point here! In this case, we need some external
>> mutex for synchronization. This is just a rough idea, but maybe
>> something like this might work:
>>
>> struct reset_work {
>>      struct mutex mutex;
>>      struct work_struct work;
>>      struct virtio_snd *snd;
>>      bool resetting;
>> };
>>
>> static struct reset_work reset_works[SNDRV_CARDS];
>>
>> init()
>>      // init mutexes and workers
>>
>>
>> virtsnd_probe()
>>      snd_card_new(snd->card)
>>      reset_works[snd->card->number].snd = snd;
>>
>>
>> virtsnd_remove()
>>      mutex_lock(reset_works[snd->card->number].mutex)
>>      reset_works[snd->card->number].snd = NULL;
>>      resetting = reset_works[snd->card->number].resetting;
>>      mutex_unlock(reset_works[snd->card->number].mutex)
>>
>>      if (!resetting)
>>          // cancel worker reset_works[snd->card->number].work
>>      // remove device
>>
>>
>> virtsnd_reset_fn(work)
>>      mutex_lock(work->mutex)
>>      if (!work->snd)
>>          // do nothing and take an exit path
>>      work->resetting = true;
>>      mutex_unlock(work->mutex)
>>
>>      device_reprobe()
>>
>>      work->resetting = false;
>>
>>
>> interrupt_handler()
>>      schedule_work(reset_works[snd->card->number].work);
>>
>>
>> What do you think?
> 
> I think it's still somehow racy.  Suppose that the reset_work is
> already running right before entering virtsnd_remove(): it sets
> reset_works[].resetting flag, virtsnd_remove() skips canceling, and
> both reset work and virtsnd_remove() perform at the very same time.
> (I don't know whether this may happen, but I assume it's possible.)
> 
> In that case, maybe a better check is to check current_work(), and
> perform cancel_work_sync() unless it's &reset_works[].work itself.
> Then the recursive cancel call can be avoided.
> 
> After that point, the reset must be completed, and we can (again)
> process the rest release procedure.  (But also snd object itself might
> have been changed again, so it needs to be re-evaluated.)
> 
> One remaining concern is that the card number of the sound instance
> may change after reprobe.  That is, we may want to another persistent
> object instead of accessing via an array index of sound card number.
> So, we might need reset_works[] associated with virtio_snd object
> instead.
> 
> In anyway, this is damn complex.  I sincerely hope that we can avoid
> this kind of things.  Wouldn't it be better to shift the reset stuff
> up to the virtio core layer?  Or drop the feature in the first
> version.  Shooting itself (and revival) is a dangerous magic spell,
> after all.

Yes, I also got an impression, that without some assistance somewhere
from the bus it will hardly be possible to find a suitable solution.
Ok, then I will postpone this feature at the moment.


> 
> thanks,
> 
> Takashi
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

