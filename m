Return-Path: virtio-dev-return-2644-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Ilya Lesokhin <ilyal@mellanox.com>
Date: Wed, 1 Nov 2017 15:52:12 +0000
Message-ID: <AM4PR0501MB2723D56ED113A7B98D3785F0D45F0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
 <20171101162357-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171101162357-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: Virtio BoF minutes from KVM Forum 2017
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Jens Freimann <jfreimann@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wednesday, November 01, 2017 4:59 PM, Michael S. Tsirkin wrote:

> On Sun, Oct 29, 2017 at 01:52:25PM +0100, Jens Freimann wrote:
> > Ilya: - you might have more completions than descriptors available
> > - partial descriptor chains are a problem for hardware because you
> > might have  to read a bunch of conscriptors twice - how would you do
> > deal with a big buffer that cointains a large number of  small packets
> > with respect to completions?
> > - is one bit for completion enough? right now it means descriptor was
> > actually  used. how to we signal when it was completed?
>=20
> I am not sure I understand the difference. Under virtio, driver makes a
> descriptor available, then device reads/writes memory depending on descri=
ptor
> type, then marks it as used.
>=20
> What does completed mean?
>=20

During the BOF, someone raised the point that there is no indication that t=
he HW has
Read the descriptor. I think after some discussion we've agreed that it's n=
ot a useful indication.

My issues with the current completion or used notifications are as follows:
1. There is no room for extra metadata such as checksum or flow tag.
You could put that in the descriptor payload but it's somewhat inconvenient=
.
You have to either use and additional descriptor for metadata per chain.
Or putting it in one of the buffers and forcing the lifetime of the metadat=
a and data to be the same.

2. Current format assumes 1-1 corresponds between descriptors and completio=
ns.
You did offer a skipping optimization for many descriptors -> 1 completion.
But it is somewhat inefficient.
And you didn't offer a solution for 1 descriptor -> multiple completions.
Mellanox has a feature called striding RQ where you post a large buffer and
The NIC fills it with multiple back to back packets with padding.
Each packet generates its own completion.

3. There is a usage model where you have multiple produce rings
And a single completion ring.
You could implement the completion ring using an additional virtio ring,  b=
ut=20
The current model will require an extra indirection as it force you to writ=
e into=20
The buffers the descriptor in the completion ring point to. Rather than wri=
ting the
Completion into the ring itself.
Additionally the device is still required to write to the original producer=
 ring=20
in addition to the completion ring.

I think the best and most flexible design is to have variable size descript=
or that
start with a dword header.
The dword header will include - an ownership bit, an opcode and descriptor =
length.
The opcode and the "length" dwords following the header will be device spec=
ific.

The owner bit meaning changes on each ring wrap around so the device doesn'=
t
Need to update.

Each device (or device class) can choose whether completions are reported d=
irectly inside=20
the descriptors in that ring or in a separate completion ring.=20

completions rings can be implemented in an efficient manner with this desig=
n.
The driver will initialize a dedicated completion ring with empty completio=
n sized descriptors.
And the device will write the completions directly into the ring.












---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

