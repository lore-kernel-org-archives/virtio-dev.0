Return-Path: <weijunji@bytedance.com>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [External] [virtio-dev] Re: [RFC] Virtio RDMA
From: Junji Wei <weijunji@bytedance.com>
In-Reply-To: <CACGkMEvP1dJv81Jy9aQV3GyrAFiYqt_y8rhz2O15wP9SWMeing@mail.gmail.com>
Date: Thu, 17 Feb 2022 15:34:22 +0800
Message-Id: <93C619CD-C9A7-4013-A780-0F98A298A7CA@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <CACGkMEvP1dJv81Jy9aQV3GyrAFiYqt_y8rhz2O15wP9SWMeing@mail.gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Leon Romanovsky <leon@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yongji Xie <xieyongji@bytedance.com>, =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> On Feb 17, 2022, at 3:02 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Wed, Feb 16, 2022 at 4:01 PM Junji Wei <weijunji@bytedance.com> wrote:
>>=20
>>=20
>>> On Feb 16, 2022, at 3:26 PM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
>>>>=20
>>>=20
>>> <...>
>>>=20
>>>>>> We can't. So do you mean we can implement virtio-rdma only for IB in=
 the future?
>>>>>=20
>>>>> It's probably virtio-IB but we need to listen to others.
>>>>=20
>>>> Agreed, one problem is that there might be some duplicated works.
>>>=20
>>> Once it will be needed, the code can be refactored. IB and RoCE are
>>> different from user perspective, so combining them into one virtio-rdma
>>> module doesn't give too much advantage.
>>=20
>> Yes, code would be fine. But there maybe some duplicated contents in spe=
c.
>=20
> We can carefully design the interfaces in order to eliminate the
> duplication in the spec.

Ok, we will try to extend virtio-net spec in v2.

Thanks.

