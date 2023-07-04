Return-Path: <virtio-dev-return-13222-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC85EB64DA
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:18:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0316542C27
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:18:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA3AA98680B
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 22:18:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD25398670D; Tue,  4 Jul 2023 22:18:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA27F986637;
	Tue,  4 Jul 2023 22:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6xOKMBuuF8e8q1GJv6XAUTh6AAHlMbcXx0yxJPNBiHahUp8NnInQlK1PrNaUMqNVIV5URPGraWLHiEcMa57O60qpVFws/UWHIvecg5CeNiZ/l6dQqr8Ul3/z6uywFMcnzuNdJNPTqVw9ehfHr82f+lIgJxv5b4WDUMh/EWjrcFd0Z5k5okqfEufVxwWHTfSpSzS6cqfKL3NoxMsQxAbdbaHzqB/daXzbN88fx26CV0+x1g2RvKm7bFyobqKeiFvFtxdYAAJyhDCFjvC5cnsA912I+jIshQzB4WeTa7Osj5AUYTOl+jo6nRJ7xiIZh+1MCUCbIxm78aM/mTbh6SOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrzuF9C4Yru/o/wbhASZx2jBsSklszBj7gRHNiHjgc8=;
 b=d/HGNcrnI5f3v7sSxfHj3EJ3fkUvs/L7ABk8mvwGXLAhz+Wj8BDzEA4j6/bJHOYtZnApRz/SswgEo3c7h6HGHLl7tZzwH151J9HEGsmZTMbD+ROHf0zR0IyIXoH1MFPlOPfkYURSVGkHCNyZqWYrqVH+M32KE5CYo1JiBVwtvlpGVspEPo/4V4GMcXOm62Io7I0wk1oa5SzKc5Xv0OOWrWKmfwZyW3nwJkbCFnXw1R51N4MNLVPFEcai72OW4KJ8B62N8QuGW5TPAlqRIM6PLDGLK7ILy1EhaPICw9Dee8q/HQU0/L52ORv4E1xg9dA3Lq1L0D8ZrbjN9cBYWV05Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v8 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZqwo9gupu6w0ua0ue/guTiCilX6+qL9oAgAACxqCAAAHQgIAAAD1A
Date: Tue, 4 Jul 2023 22:18:39 +0000
Message-ID:
 <PH0PR12MB548101FF45924753EF37E033DC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230630042006.1569920-1-parav@nvidia.com>
 <20230630042006.1569920-4-parav@nvidia.com>
 <20230704171700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817F7888F3FAA6F8874055DC2EA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230704181622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230704181622-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5391:EE_
x-ms-office365-filtering-correlation-id: bd1b222e-cab4-462a-5fa0-08db7cdc9e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TMaOQgCIyj+QR36WJj9PZ7R437aLyVDygU2c5ujwI885HDk+hF+Bk/a0iyq9r5J0XnkYIFzoHJNGfB5JsX7svC1XtpjYt0n0H1hkVziqA3nBcDl2A9cei7ojVRt7oGI7jstKn4Ojvo1O/xDZMpLJlbF+LaD68qcQLw6A0iJx7mh+14zbg7kAxo/RcPw8CHVEJ7N8W3Kv7DFnnsOvWUjyHoULiST6fiaXVH3v37FJFJbfeeybcvg8ZT0cSP6XKVx9R+ffhipnqCi/17wlh+gkDTC0p66kk7IxL5reMWuJExnl+8W0+JdPlAzIACDQnEtiGw/vuFEWa2Sb4t9yn15t8YMW5xezzLUgiwHuzRtNX105zlgsNZoeJPIUTTS7Ap0HVIFxTy5BxWHpIpivJeA77vx/ngeZLnRtYVj79UEMgtGQeByC9+Dqxw1rSe43ctQJj8nPmtVxaVdi3ini+pgjMInO4iNVPyPuN7VuTyowf8RVlPwMglJycTYS/XejvDG+L9OiV4XWRvFQDMXwug+TcFJkOC2E6jD++OvGerAJDNuhukcpYhlN9MZVVuDue5ExF5Tmd8wzD76t3f4o3O1fbq67MmYYF1Q4jqmgW4w+j20=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(186003)(478600001)(9686003)(53546011)(107886003)(26005)(6506007)(86362001)(71200400001)(38100700002)(6916009)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(316002)(83380400001)(122000001)(54906003)(4326008)(7696005)(41300700001)(52536014)(5660300002)(38070700005)(2906002)(55016003)(33656002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YTyGu2pqMH6V8M9N+9qyYDnazGhVlT/H3z6VL6Ev9w6I3nR0EsTGTEY+ZTYg?=
 =?us-ascii?Q?Nkz6gjVFb6smqN6STAKFRqBfLHGwvF59TVZVoxtXBiyLEi5iXrAkhcCxLf41?=
 =?us-ascii?Q?kuvaO76BvsiqEcAUj/UkG2isf9TDh/ezWJKnA0Kmlmizn3FAhxbNZW1iC+97?=
 =?us-ascii?Q?dEpwkrwkKDEe/w+d48fn25EohnQ4fu8WoFCj2e2bkf24xcPmUwYdK4cIZWFD?=
 =?us-ascii?Q?ESzi9fyMT/hDC6idPiJSjGrx3fzG/JuOwZ41ZTRc7ErU3sw9ab54ufhR/v/I?=
 =?us-ascii?Q?fuq3C3nWmgN2laaGiNNS0yzZLiTBIkmTumLw9GfcvKfPBe236GEhTOL4bows?=
 =?us-ascii?Q?/qahzSAr0ZTl+9+MSzErPOZl5CiahZAIxSEsOJn9LCqZSQGfHks37fy8vju2?=
 =?us-ascii?Q?0VJkDnsz1qwzrlt0H6xlsQ77dArrHiMEoakcCauOZXHxtli9QWze5ygjfpbq?=
 =?us-ascii?Q?KabMPJpJuzAnTNYN4yCX/orNaetTLw1cRdsdvTY51AyrQh96QJjV8OL1vTNK?=
 =?us-ascii?Q?xGGu1p6L2Tm8KBooHUFBLG69WNz28uA/gBjSBX07xYCloLqBZNEeO81Gw+j2?=
 =?us-ascii?Q?tnEW6WYMrvd2/ksBN355Bd0jNrc6yCPjxQWu5g8PQ+wdtlzPXByllNa1ESIp?=
 =?us-ascii?Q?XnEXjOwUIHI/h4Lfz9l/p2jgXjQZ4We+RwFUVxmUeh28QNNA5bhLaZDWtS99?=
 =?us-ascii?Q?2UEJkEc5LNpWEukzqVMacU/hOdrWTgf6kGHuHTOnJOj/iro5FoilUg2mENba?=
 =?us-ascii?Q?4IPy1eDwH7uX0kIQhuzxbugTviV5GkwNqtgu8nI0cexWHxkxzx3ONTEPlg51?=
 =?us-ascii?Q?5ZVVD349znuxpN+GWARierqGi5+BLgozcq9Bz+KR1BQwc3aUxPumbeWLd9QH?=
 =?us-ascii?Q?gW8SMl2F4IPqQPOtWUSd7VvaGc+RgXzLH+DY0MI+KfSy43s2FI9bXnNIy6wy?=
 =?us-ascii?Q?6tLkSWWqHh9DDrOA4ucjJzFvC00nT1sa+D74CXGqi4+fpBLIljxvns9UKozk?=
 =?us-ascii?Q?P3MtB0E9htx+SLWwlxw54lHU2OWBFc+xj804YP/YDchRx9wnDqAk0Sa2kASo?=
 =?us-ascii?Q?J78bGC1CgcWoR7/vJlzMhGgmMHOhFNvoHBpmy8N6SiYgBR8nYHD9tYBZN10v?=
 =?us-ascii?Q?38FvKplfWmghHQxSvuKrbF8+eG1bXOgXL0GoYQFNZCtWgIiuaVlKffKrtcAu?=
 =?us-ascii?Q?eQLy4mY2D612So9EGhnJZgQ/SKLZWsZLnY/39hiuy0fxmYliBekcOiYATNzg?=
 =?us-ascii?Q?vFX53fAOeSsv8ZmZA202yFy9RJ4/E8PI1dnK9jUkF2KsDLctahRn2ePHOVfh?=
 =?us-ascii?Q?t152wp3Id6w9/Hs6CM21YgNfhDl3IzLmOTH0sqDrIJnIMY/d1QE5qPpW+Spi?=
 =?us-ascii?Q?+c9i7ryw7v8cW7X/NRUiwhGWUpY8Uh7UMPsa1d0RKJ0/5VRrbDzl/y641BG0?=
 =?us-ascii?Q?tKOxfQywYxwQ8PLiWOUyIdHQCHuUPJplf8GDSeFGdrta5sBFFSPi+KMKXj67?=
 =?us-ascii?Q?/TRmxZaIkvn0C+AvUV016MNjuIlqn7x6H3G830ojFb+3i9b9x3z6nK29U/h8?=
 =?us-ascii?Q?lupu3rGoUFu6HWb12rA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1b222e-cab4-462a-5fa0-08db7cdc9e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 22:18:39.7710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bv/wr4dxkfCs4xOihbw7f+1sQicsLGbVVa9bZKLFOhhVj++Bl8QgiHizC0mt35wKD3qbMEWmqKspsdo3Lb4pqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
Subject: [virtio-dev] RE: [PATCH v8 3/4] admin: Add group member legacy register access
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 4, 2023 6:17 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: virtio-comment@lists.oasis-open.org; cohuck@redhat.com;
> david.edmondson@oracle.com; virtio-dev@lists.oasis-open.org;
> sburla@marvell.com; jasowang@redhat.com; Yishai Hadas
> <yishaih@nvidia.com>; Maor Gottlieb <maorg@nvidia.com>; Shahaf Shuler
> <shahafs@nvidia.com>
> Subject: Re: [PATCH v8 3/4] admin: Add group member legacy register acces=
s
> commands
>=20
> On Tue, Jul 04, 2023 at 10:15:34PM +0000, Parav Pandit wrote:
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, July 4, 2023 6:01 PM
> > >
> > > In some systems, there's need to support utilizing legacy drivers
> > > with devices that do not directly support the legacy interface.
> > > In such scenarios, an owner device of a group can provide the legacy
> > > interface functionality for group members.
> > > The driver of an owner device can then access the legacy interface
> > > of a member device on behalf of the legacy member device driver.
> > >
> > In the last line, I will change from 'legacy member device driver' to j=
ust
> 'member device driver'.
>=20
> I think it's important to stress legacy since normal driver that follows =
the spec
> does not access legacy interface at all.
>=20
Alright.
Will keep legacy.

>=20
> > I will fix rest of the comments including having pad bytes after offset=
 and have
> similar changes in rest of the places.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

