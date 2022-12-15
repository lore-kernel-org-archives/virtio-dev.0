Return-Path: <piotr.uminski@intel.com>
From: "Uminski, Piotr" <Piotr.Uminski@intel.com>
Subject: RE: [virtio-comment] RE: [PATCH v8 8/9] admin: command list discovery
Date: Thu, 15 Dec 2022 09:52:07 +0000
Message-ID: <SN6PR11MB351785B5196165709E603082FFE19@SN6PR11MB3517.namprd11.prod.outlook.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
 <SN6PR11MB3517ECBE658C18BD9B7E355CFF0A9@SN6PR11MB3517.namprd11.prod.outlook.com>
 <20221215023955-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221215023955-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Jani, Nrupal" <nrupal.jani@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
>=20
> On Mon, Nov 21, 2022 at 11:06:14AM +0000, Uminski, Piotr wrote:
> > Instead of a bit-coded list of supported commands, can we just use an
> array of supported command values? It allows us to use non-contiguous
> command coding and checking how big  is an array:       le32
> device_admin_cmds[];
>=20
> Interesting, what's the usecase exactly?
In some protocols command IDs are grouped, for example:
=09Commands 0-99: standard device management
=09Commands 100 - 199: vendor-specific device management
=09Commands 200 - 299: standard queue management
=09Commands 300 - 399: vendor-specific queue management
Initially in each group only some command IDs are used. It makes it easier =
to add new commands later.
> I don't really expect more than order or 200 commands - about 8 dwords.
Agree that the number of commands will not be big. However if we define a c=
ommand #1 (say standard one) and command #100 (say vendor-specific), we nee=
d to use 4 dwords for 2 commands anyway.=20

> And the operation we normally need is checking whether a given command
> is supported, with a list that will be a slow lookup.
I don't think that is a significant difference - this is once-per-initializ=
ation operation.

> Besides with your idea driver first needs to check how many commands are
> supported, then do the query - two roundtrips to device.
Right - this is the main disadvantage of my proposal.

> With the proposed interface, driver just allocates a buffer for commands =
it
> knows about. Device truncates the buffer to the length supplied by driver=
, so
> any commands outside the buffer are ignored.
>=20
> --
> MST

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.

