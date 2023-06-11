Return-Path: <virtio-dev-return-12929-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329A1C77B7A
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 12:55:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7195D2A887
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 12:54:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E69498669B
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 12:54:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 62F4F986534; Sun, 11 Jun 2023 12:54:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D3B99863E4;
	Sun, 11 Jun 2023 12:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN8YiNZFk3hnGcf617CGcnt6Yb3tIVkrVIjr9jRqGrM1HAFDnQilJbCK3n+LHSqU7NOhOXA0FSA+qCBuqqBnKo3cKOcFb8TwRptGknZ/MykzY455PAIENpRlMBtfvljY67vxeQfZS2g73lsb0gILRd1L+0o0UyhYtIuQXFOYglUfFpVJgxpgl1Eg9jqZYFrn09pEnPiCjQr9+HqVOx6RBQwyBrjaOmwd7Cs/yRgY8MTgukPYg9zLSFfu8r/m6A3WM9eEaWeaTDs69+tlbx+LKw6gaTD/vM7O5Dvtl8IfTxQE1MThMNjcYoeDx90zEK+zpZmvKUvMHIjCeFXeLMuolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKMWTjZ9U9MqJrYD6WfTToTSkzcL1M78/1nyzzJx5sE=;
 b=aD5JIZi8HeSaro7AyIvUvlNcLWawFZpWrFQWlX3n053jQzut2LITrfoeHjv8gvnIUxu23SsmLjrFwF5ROxe31Yld6V1xxlCquTzXgDE+pHMOatL8/KaTEPNOLGO67C3zHib5+H9ricYsnEsgiNMRrdLdfdlnMFh0JYSufS17xfuSaaGtgTE6vyTSt4pdjgAjDLO8lfaPujueuuXadC0DQhK8hVmaJRAXSPWsoowEp9GMQl+Xx/X42aS6/zbGOcrXV5wU2E03ev0SePXpXpE3cBTiLcPqXrtCFERHKU51xPW1EourOqwwB8/a5XexytcmGX8vDaA5PyafrknNR0B36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxggAACF4CAAAAyYIAAAZcAgAAARXCAADjCgIAAD1EAgACbcBCAAhV1gIAAG61AgABWJQCAAF7h8A==
Date: Sun, 11 Jun 2023 12:54:53 +0000
Message-ID:
 <PH0PR12MB5481C7D98AEB2C3328CCF635DC57A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230610202143-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54807B410DCF097D0DC969A1DC57A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230611031129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230611031129-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6428:EE_
x-ms-office365-filtering-correlation-id: 0cc7272f-57ba-46e2-ef7a-08db6a7b0d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Bxe5KCRXUIJET71mXWvJRA+3r/iX25UorXDAz8BOVmlT4pu549ZRd5C6hpLTQ9yJ0+GQ0urznRaAFRM5FEsITBJtP9tVSSfm+eSc2FWfbYaOlbVvGte5DmCKD9N2Mz8sPbmgcMMS3IObCnCK1miKBFzyX0x1PSjdWEv506NPVbCpwJw75p+kGzTKg4WtQrpyjwAIYA79c9ZJmX3wkZuHGz32OxdHvCogaoe4YAHrK4e0PP8++D/9tW5w5uA28uQIXztzPEnNcCOtmKbZ2D/HKQoG6vlO/j/whGdb6nkeUzMB6UgMnxh+oU6h3YuwzId+56ht3ulVbI9Ua1/2HqeITAnDZMsgtB21jLmewXT35sbJb4G9OVPsXOvz0nwqaiJl5iGzJ6PQb8+n++uqqCryDnPA6xiqju697XrCjbigF8qG+P+vDkzP5U2PMSsjbjHtS1Jhgk/x8gdVzaO7dpqygn4mZL/uSsIGp1U6a3Lq3ZbQfxkvjb/LamrIvoqT/3G4CCsUuEf3EW8cUXwTFQFrFH6vzP//OkrxXERl5FxYyq9tyRoskY3ZBRNCUQ4kaH5krnN9g74ofaPXly7B+NCOIMVfjeA7EiQTyRB1PUDTwpQ/ph+xMpPRQjHNRC+bMnIo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(86362001)(107886003)(7696005)(316002)(8676002)(41300700001)(38070700005)(83380400001)(5660300002)(26005)(55016003)(38100700002)(9686003)(122000001)(6506007)(52536014)(33656002)(71200400001)(8936002)(66446008)(64756008)(66476007)(66556008)(4326008)(66946007)(76116006)(6916009)(478600001)(186003)(4744005)(2906002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Afw/yOfz0yRz3IdSSV0nNPHo166+lRQJZ0lzg3lRlsEmmOAH8mG/kg5F70bg?=
 =?us-ascii?Q?Zaz8dWmNyi2riZO0H6AVnVMT3fZcwj/+jFOJOKePeFrH52rvaPtTGaZDVqdk?=
 =?us-ascii?Q?aC3d8vovYBwL2Wd6zpF5GEnzB+eJkUpd6+OKx842pMSWYZBAtWWYfpgEQfSl?=
 =?us-ascii?Q?fug0aM42RkQtvChOK/jK7kY/EC1YER11EGqWyBhdgFqia2Zn4tKD+WDNS/xT?=
 =?us-ascii?Q?ZRITJL261Dui+EONHf94xFm3mwdXSJwsUcFvoY1HQmjkIJmHIpaZ82zoYTcU?=
 =?us-ascii?Q?KqTIRrMKXzKiSzZBKg4eron9HCMl22U2vlwASrDtIQ28u10nTzSMATpffOqQ?=
 =?us-ascii?Q?61kp5WaqyP2/AXs2Kwgbw0Os4GrFiDNO/cBaJBN+Zpat//3uO2+nGcveNDPw?=
 =?us-ascii?Q?6SFO22dEOMEsJKbhW7g0t1wTwp9ZcyblWJH+hT3jYR7G9zYl0LiMwFqtDxrZ?=
 =?us-ascii?Q?5OsOGJE0V4nVTumcDATxahpU79m+wwmXyj6iDEFwzceif4eRAFHG/hCFfRyT?=
 =?us-ascii?Q?We0ux0GpH0FRd9AjudsuXVNN2q3eXO/NhB78MbduPOdhhHH0U/VVOrg86jpG?=
 =?us-ascii?Q?BNEr85IXXMg0GX+wEUpWUON7EtqcQbvTybNnCnhGUe4qoVisbPw/lOG6c/zs?=
 =?us-ascii?Q?5gRWjlJK3qjq3o6nG/O37B0wvxXNCE7B0Gw9w8nYrMWtnLwLV4GPkVSZf9LX?=
 =?us-ascii?Q?iO9n4xPye93ve05gGQtF+Ohrs2McaVScaBrL46dBx/VD5ks9EUlvrn9Xyxdn?=
 =?us-ascii?Q?0AfITLyHK8gAOPbqofMKb/nOYzPTeWkEtFfDGh768woSvoHGNU7RE4v6O3/t?=
 =?us-ascii?Q?Uch8mhNsP1FOLA5wrlL/ZhTfnafTkcjtfs+5Rj82QzBAdJjdgGk7UhSce/Lc?=
 =?us-ascii?Q?At6GW6zbRJN5VFSapKdzhPHgVlQwfPhGPajCwQyWUCYfeDWoHoU4mqBtkk84?=
 =?us-ascii?Q?Wj3sEv6wpxc7YxJeRqDrdDz+9Nfsv8i/IcliI+Bu0GrALWMd96z3r8v/hLzw?=
 =?us-ascii?Q?9Ukku6HEojv1I84K1VpX48/T0zuKz60jfb5SZR3ft6b7quChbCEWBSQvNwy3?=
 =?us-ascii?Q?2I2cvN1xlDnzbi9DN3jgpft4GjfRgfMV5dZTd+2nTnADdv3+s6ep8B31CtvQ?=
 =?us-ascii?Q?W2F5niyHeeg//PGjZ3mj2UzHSa/usVzOy6e06ivR6nrUBEZFb2e6SbhJO4wo?=
 =?us-ascii?Q?VZqSfXx7n8HuIWrcAleZbj3Um7SLFCq3daETwdeS7TT1zYqavzigi5KHpjQo?=
 =?us-ascii?Q?H6V/QGneieqssWwq/DpDAoPpQmYPR49V/UpA7W9Ef+kGTv0Ns9FMOpAalyXN?=
 =?us-ascii?Q?q3pfPDWohi8EhXaXHClHy02ABNJqfGsAD8r8NrXFn+rQIsC9Kwp/oqv6BEoM?=
 =?us-ascii?Q?f9Zu3NcG/47wbOBMXC7QsoPHzK8G76+D1Yr5SbupvwIuF5VyNcLZ7qbEOZoD?=
 =?us-ascii?Q?/HgHx01hVccRMMQl06dGr5AHvyY5Vdae94CfbjHOXyvIoRXBAXQmZ1oEON8a?=
 =?us-ascii?Q?U1hdCakoXArPjoC3p+/NvvzcJiOTW8Se1tPldD/wf/aUtsoZTRVtJsfbxCAX?=
 =?us-ascii?Q?EWaQztDBFu/Cf18wI9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc7272f-57ba-46e2-ef7a-08db6a7b0d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 12:54:53.9337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /209OvecxZ2GB6SYyJfv8x5QN4Xx5lUBtKuKzsw4ar0Wy1NZe/ttubU+kkmz2GIIT+9K/SX4JJ0mClTIg7wLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 11, 2023 3:15 AM


> It's not conformant to that statement then :( It's a SHOULD which means i=
f you
> know exactly what you are doing, there could be exceptions.
> In this case it's a SHOULD because it was added after 1.0 and we did not =
find a
> way to negotiate this requirement since it's the feature negotiation itse=
lf.

True. May be in future such device can update the revision id.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

