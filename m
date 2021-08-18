Return-Path: <arnd@kernel.org>
MIME-Version: 1.0
References: <bd0f81517c064b333ea5263bacbb74385e0d9b3a.1629107000.git.viresh.kumar@linaro.org>
 <20210816104430-mutt-send-email-mst@kernel.org> <20210817035324.r27cdx3yu2j4qmms@vireshk-i7>
 <20210817024607-mutt-send-email-mst@kernel.org> <20210817104314.yg2ybrodkpnfwpoq@vireshk-i7>
 <ade98cbb-ba4f-ae59-46a0-09b518d72ba7@intel.com> <20210818032644.gld65jqwvxjgwqeq@vireshk-i7>
In-Reply-To: <20210818032644.gld65jqwvxjgwqeq@vireshk-i7>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 18 Aug 2021 10:03:55 +0200
Message-ID: <CAK8P3a30e0-r7QxtSbRiBwOuM84TdftCz7mOTYwazHjgg=2egQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH V2] virtio: i2c: Allow zero-length transactions
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jie Deng <jie.deng@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 18, 2021 at 5:26 AM Viresh Kumar <viresh.kumar@linaro.org> wrot=
e:
> On 18-08-21, 10:38, Jie Deng wrote:
> >
> > From the perspective of specification=EF=BC=8CI think we can allow zero=
-length
> > buffers in virtio.
> >
> > we can use the len of descriptor to see if it is a zero-length buffer.
> >
> > But for a specific implementation, I don't think "NULL" can be passed t=
o
> > this API.
> >
> > There is a check "BUG_ON(!virt_addr_valid(buf))" in it.
>
> I tried to look at implementations of virt_addr_valid() and it doesn't
> check for NULL specifically (for the ones I looked at). I haven't
> tested it though.
>
> Though I am not sure what's better here, remove the need of sending
> buffer altogether, the way this patch proposed initially or what
> Michael has suggested. And all that to prevent just a single bit to be
> used in flags field, which will likely be used for more things later
> on.

I'd prefer your earlier approach.

My feeling is that changing the virtqueue code to allow zero-length
buffers is more fragile than having something in the virtio-i2c code
that has a special case for leaving out both read_buf and write_buf.

Even if we fix the linux virtqueue code to deal with zero-length
NULL buffers, there are other implementations that will require
similar workarounds for existing sanity checks.

       Arnd

