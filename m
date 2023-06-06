Return-Path: <virtio-dev-return-12874-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95142C77B7A
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 07593F3F40
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02E32986655
	for <virtio-dev@archiver.kernel.org>; Tue,  6 Jun 2023 20:16:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E84E3986586; Tue,  6 Jun 2023 20:16:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4FB6986589;
	Tue,  6 Jun 2023 20:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vh6HXeSA8S7ggl0xSND7eMLWDo0shsf3S9RpPzkikj+9H7kLbTXy6DfgnQwUkqMS/YE297s+sFgraTk6ibM1j3VRpG9S4oE6doNR3yiwkG10qRGGN3dXhGsY2ml79fRK0Tlgq3E090NkVzK21QWrTklfYOL5wxYHHRKh9iH3IWHWVAISN2ZJJV4BvcTQePfm/DmNewiaxpr0TMuAdXNtFNsqF+MS261nSC7E/AuofaVzFgyzgwZMbzOKYjc2QQsu0hwpzS6JCiMEdvc92ujJjcfhGtwMcJj7ii7SG0C3My9kV9vKBdA70QtGMVBXAleKPeceaf3IrDVvimw3A3FG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuFJixdF21Gj+YF+gnxcmbmT3xctxQiaYfKorI9pr5Q=;
 b=ST0d5n/Vkvdz9mHAV5g++Rf33LceR1r2BvZn9uJbwci7NpxG8lYuMzvJaYv5wT05uIPk4x5IqCDryMD8eu+fu9BAicGw6MHvlv1ZR5OxYS9FxxgWqpKjbp61zQ6RHMZVCDetDmnc5ZI/3c4z/ruSD1Lr84GLXLrwq9pA6o/RY+5L3lWHGFLE11tHTgmuEHoGiDr+5/KwE1cUfH2area933ZHjNhYpbEVwY2s9f76wNa8lHSVAylres6TZ2T08wbCkyzJU1Gj58usmRZKd4wNFmcuj0/+WubmNq9DXHrZOOWsELDNSKQ0ItxiA0g0h45WYKqaigNbmqLcMJGGN3OKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAHtrcA==
Date: Tue, 6 Jun 2023 20:15:55 +0000
Message-ID:
 <PH0PR12MB54814C1AA49BBE3F49E2B605DC52A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230606073544-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8156:EE_
x-ms-office365-filtering-correlation-id: 19fcdd02-eb8e-48d9-56b0-08db66cad596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jR8GGElSMTnjqZoZoANk4ywZy1VIBh2IhFD4N5MQ0xIwmfrOpWoo98TjlQRgg9wd02KHcrdxuvy93qZynV7rTWVTWwu9e2Q04vElLn6ngn/O3c4LODgYexizCf9kxu+HWZsvbBo81GBVVOsqiutB4cMAhA/lsNg6WvLW5035fOJX7++7s1dYeIhDeFsm/rbB1SUgN+PNrUFjBhlISmOBirYL3vPKtW41lvVECubUy0ASPAwkKg7gb2KAounwuaMyjqi4JDFrThqEvYHo1wUNKHwfCCfptTDF8hcyBcS9CIO4naspYVqNVA3dfRas35/am3ISL8COGR/QCa3Ab54RkisQwxvTHT7SHanJr1XrCXBGIYS8mDpOdFkAaGcbZgNAkbS1VK5mCYRxzLKcNo9PTtlRbq6wC+a8aEVa3jh9tuTpRlqceTHjRdvMEJLOkFXOqo+N4tO6PVusXrNyHzcR73Y0MI/mZtmdFuLGKu664UbgICa8HEDHxx3I8tz2b2LehD4PWeVYuxjOHkj43VzC1wFeIKYqdqN36B+gA/8BgW9nAfvSqqs7tXPP1wAXoA6IzGEAPqKqP9xuew/UZKMhwLAMvQjc2NZG8GrxHhwZD0soYFzu6/ZYGkmN9GBNqj+G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(86362001)(66446008)(6916009)(4326008)(52536014)(2906002)(5660300002)(64756008)(38070700005)(41300700001)(316002)(66556008)(66476007)(76116006)(66946007)(38100700002)(54906003)(8676002)(122000001)(8936002)(478600001)(71200400001)(7696005)(186003)(33656002)(55016003)(26005)(9686003)(6506007)(107886003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zEXJ5XcYvuDL3IOzJDViF6uGrcCqctOQe2ByIBZN9vL/BhWkVLG4xVSEPTh3?=
 =?us-ascii?Q?B5XvABWgnIjdeaLWwEWt/OKQKujgSd5Jq1vGg4GTr+ezRwY1aGa5xmwZ589A?=
 =?us-ascii?Q?iJ1Z5CZ+unkyPf45z3A8bHTsSShoYMOP7fKuTanvd7EvaN7A3SixsnkDsMiI?=
 =?us-ascii?Q?aLxVqxPRdgEg8fIXZkw4dsSRPlEnK4czitHJuFjk660YdPAXn0iPXPM90Y+X?=
 =?us-ascii?Q?1gM5lUmhWbQaASldteqylR4BP/8ZfCeJNjuviFgiml6ScUCcVzferfHi0kSK?=
 =?us-ascii?Q?pDeE1VYAthsAXm1oQg5Jsq7qG+VvDgq9gRXV0cJJN7zfFBLgHOEYauhSFxSH?=
 =?us-ascii?Q?Brq44Mpr7/ea7pugRCJdJT667HmDwqdm81WA3/0oMiLc7/agIvGknYcLNIG6?=
 =?us-ascii?Q?+PZZ6JJq2WQP+YEwTuXb+tvROD4mI5vF5cPLsMfOBfn1vAaJFkRRIwxSY/De?=
 =?us-ascii?Q?blyElDyAfddM2ZYS77y9ChhqFQKvutFZJnPFUM1ZUJJXKVidBkiYtuvaUZ/5?=
 =?us-ascii?Q?EK7iR8LTewOhxRBAeqYk3NoByaFAooqwgjuJach2O/Kh6fBzKPdOdYwMI7fa?=
 =?us-ascii?Q?kKYOpHNY6KIIP9OgUPkgavMIfW506gNd2ZTFaXoxNrsBijrAO7T6HoqGgpza?=
 =?us-ascii?Q?GkLEtWQAv7qKofgCx1iHPqFWD3mwdrXNfBuYHegakfl/BoIGg7wXHlUfhwhE?=
 =?us-ascii?Q?AtZyTYsF+DkeWt25kfkmRuRmAUNN0AqQ1ZV/jLOarz1+v8E/COhrctfAZF5A?=
 =?us-ascii?Q?uboRiAjPl347jxtjb2V3yqdjOyN0sWmY6UaKSAF+4rjlMZ+wEXawx14N9Wn0?=
 =?us-ascii?Q?eHSptBMDSFaNwtdX0FB3RrupaJ16wWyUJprhEpU7kfbjVUbLS1nXE/emq+Te?=
 =?us-ascii?Q?uwHhHmrLdRIjCSuhCwMxSbargfujz19liBbBtyErHSnCSjiNr8+nnErmkxFv?=
 =?us-ascii?Q?jH2AJN4++CXsx9ClqgfnozIgVZKbOW7s0hP06ndpPXTEYsjpFq45TON24EqQ?=
 =?us-ascii?Q?FkiP8dtBkUnl8V93BLOCMIHwMgyMQo6e5C0PPtH4eMFjgF4rZA0ID1t09KOe?=
 =?us-ascii?Q?Hf79y3MZ/ScWmiOYGLHfpWjkCEEW2tmYzavNy01VYQ/qj63IGBlOYbIQ/uib?=
 =?us-ascii?Q?8E9AIlK2uhW9A6qaTb4oplJF4AIOiMZyBKXUJUH/8z2mwU/mLhs/AUlTYZ3k?=
 =?us-ascii?Q?pECUta6yz75yRw3EV2jA7h8OlDV2nCnv7J25JPjgHMJjD+rI7z+dTVyLydl8?=
 =?us-ascii?Q?Xl6ec2S1AtLJ6rfhNabfaIAeKsBinLh67sef9kyNLUlif7/4/SIwaTRQ2QA6?=
 =?us-ascii?Q?9UeBAyxK0PgID5KsIhuioLeqlpc6CPk9fi07IJxwzcFIb270hEYvvQWEv025?=
 =?us-ascii?Q?M+uu3bEJFCfGj2PYA0BdGLbH13lRFv6GMpISfx8WWV9PynOrWv/G+kXSmKsc?=
 =?us-ascii?Q?S2YiqAEYOO9SeZaVk7t0uDfaoMPlTopmgl5PqMDCvYmBTC8kGqMiixd4cHiL?=
 =?us-ascii?Q?hZ6E3feEqnALANsS13nlFJ2AjAmiPmUrLXafB66h7Iy6fdn+lZ/rBVfMGkum?=
 =?us-ascii?Q?5TqsHQTRqk7bESmPCEs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fcdd02-eb8e-48d9-56b0-08db66cad596
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 20:15:55.5840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oM8TQTreAEQDXe/rucjyIPZgpzaUR/Bjj3MbuHe1PR/w3i5Zu9dDokC1U1vNJTHxSc0kTXzLpvDchzMRiO/Yxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, June 6, 2023 7:56 AM
>=20
> On Mon, Jun 05, 2023 at 10:12:59PM +0000, Parav Pandit wrote:
> > Rolling v4 now.
>=20
> Great thanks! I think the result will be in a good shape from the ABI poi=
nt of
> view. Good job!
>=20
Thanks.

> I think so far Jason was the only one with significant comments on the se=
ries so
> let's see what he says.
>=20
> From my personal POV what will be left to do to get this feature ready fo=
r
> merging would be
>=20
> - tightening the language:
> - thinking of and addressing all kind of corner cases.
>
>=20
> Since by now from our email discussions I have I think a decent understan=
ding
> of how the feature is supposed to work I understand how these things work=
 but I
> think there are still things that would be a bit unclear for an unprepare=
d reader.
>=20
Many aspects are covered in the cover letter.

> Just to give a random example, there's no explicit time where the member =
kind
> of switches to the legacy/back to modern mode. I am guessing setting DRIV=
ER
> bit through legacy interface does this. We'll want to list that.
>=20
Switch between the two is the same as today how a transitional device acces=
ses both the register space.
Hypervisor level vfio tiny stub driver is not involved in such switchover a=
s today.

> I'll try to help find these issues and maybe even suggest wording.
>=20
Sure. That will be great.

> I've delayed commenting on these until the high level design is agreed on=
,
> didn't want to make you waste time on polishing as the patches undergo
> significant changes, and I suggest you do the same in v4: let's make sure=
 there's
> a wide agreement on the ABI then focus on the spec language.

I agree, now that we agree on the design and ABI, lets polish above aspects=
 you told in v4.
I posted v4.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

